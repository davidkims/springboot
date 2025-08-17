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

# Update system packages
echo "Updating system packages..."
apt-get update -y
apt-get upgrade -y

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
else
  echo "Skipping IAM policy creation; unable to determine AWS account ID."
fi

# Verify connectivity by listing S3 buckets
echo "Listing S3 buckets..."
aws s3 ls || echo "S3 listing failed. Ensure credentials and connectivity."

echo "AWS environment setup complete."
