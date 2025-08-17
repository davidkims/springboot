#!/usr/bin/env bash
set -euo pipefail

# Install AWS CLI v2 if not present
if ! command -v aws >/dev/null 2>&1; then
  echo "Installing AWS CLI..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
  unzip -q /tmp/awscliv2.zip -d /tmp
  /tmp/aws/install
  rm -rf /tmp/aws /tmp/awscliv2.zip
fi

# Configure AWS CLI if credentials are missing
if [ ! -d "$HOME/.aws" ]; then
  echo "Configuring AWS CLI. Follow the prompts to set credentials."
  aws configure
fi

# Update system packages and install dependencies
echo "Updating system packages and installing dependencies..."
apt-get update -y
apt-get upgrade -y
apt-get install -y jq

# Create a sample IAM policy (idempotent)
POLICY_NAME="example-s3-list-policy"
POLICY_DOC='{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Action":"s3:ListAllMyBuckets","Resource":"*"}]}'
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text 2>/dev/null || echo "")
if [ -n "$ACCOUNT_ID" ]; then
  POLICY_ARN="arn:aws:iam::${ACCOUNT_ID}:policy/${POLICY_NAME}"
  if ! aws iam get-policy --policy-arn "$POLICY_ARN" >/dev/null 2>&1; then
    echo "Creating IAM policy ${POLICY_NAME}..."
    aws iam create-policy --policy-name "$POLICY_NAME" --policy-document "$POLICY_DOC" || echo "Policy creation failed."
  else
    echo "Policy ${POLICY_NAME} already exists."
  fi

  # Create or update IAM user and access key
  USER_NAME="${AWS_SETUP_IAM_USER:-cli-user}"
  if ! aws iam get-user --user-name "$USER_NAME" >/dev/null 2>&1; then
    echo "Creating IAM user ${USER_NAME}..."
    aws iam create-user --user-name "$USER_NAME"
  else
    echo "IAM user ${USER_NAME} already exists."
  fi

  echo "Attaching policy to ${USER_NAME}..."
  aws iam attach-user-policy --user-name "$USER_NAME" --policy-arn "$POLICY_ARN" || echo "Policy attach failed."

  echo "Generating access key for ${USER_NAME}..."
  KEY_JSON=$(aws iam create-access-key --user-name "$USER_NAME")
  echo "$KEY_JSON" > "aws_access_key_${USER_NAME}.json"
  ACCESS_KEY_ID=$(echo "$KEY_JSON" | jq -r '.AccessKey.AccessKeyId')
  # shellcheck disable=SC2034 # secret key captured for record but not echoed
  SECRET_ACCESS_KEY=$(echo "$KEY_JSON" | jq -r '.AccessKey.SecretAccessKey')
  echo "Access key ID: ${ACCESS_KEY_ID}"
  echo "Credentials saved to aws_access_key_${USER_NAME}.json"
else
  echo "Skipping IAM user and policy creation; unable to determine AWS account ID."
fi

# Verify connectivity by listing S3 buckets
echo "Listing S3 buckets..."
aws s3 ls || echo "S3 listing failed. Ensure credentials and connectivity."

echo "AWS environment setup complete."
