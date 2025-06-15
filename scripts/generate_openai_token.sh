#!/usr/bin/env bash
# Script to load or create an OpenAI API token.
# Usage: generate_openai_token.sh [token_file]
set -e

TOKEN_FILE="$1"

# If OPENAI_API_KEY is already provided, use it
if [ -n "$OPENAI_API_KEY" ]; then
  TOKEN="$OPENAI_API_KEY"
elif [ -n "$TOKEN_FILE" ] && [ -f "$TOKEN_FILE" ]; then
  TOKEN="$(cat "$TOKEN_FILE")"
else
  if command -v openai >/dev/null 2>&1; then
    # Attempt to create a token via openai CLI (placeholder)
    TOKEN="$(openai api keys.create 2>/dev/null | tail -n 1 || true)"
  fi
fi

if [ -z "$TOKEN" ]; then
  echo "Failed to obtain OPENAI_API_KEY" >&2
  exit 1
fi

# Mask the token in logs and export
echo "::add-mask::$TOKEN"
echo "OPENAI_API_KEY=$TOKEN" >> "$GITHUB_ENV"

# Output token for step condition checks
echo "token=$TOKEN" >> "$GITHUB_OUTPUT"
