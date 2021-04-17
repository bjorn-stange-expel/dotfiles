#!/bin/bash

set -e
set -o pipefail

export AWS_PAGER=""

MFA_DEVICE_ARN="FILL_ME_IN"

PROFILE_NAME="FILL_ME_IN"

MFA_CODE="$1"

if [ -z "$MFA_CODE" ];
then
    echo "MFA Code not supplied, exiting"
    exit 1
fi

echo "Fetching new credentials..."
aws_response=$(aws --output text --profile "$PROFILE_NAME" --region us-east-1 sts get-session-token --serial-number "$MFA_DEVICE_ARN" --token-code "$MFA_CODE")

AWS_ACCESS_KEY=$(echo "$aws_response" | awk '{print $2}')
AWS_SECRET_KEY=$(echo "$aws_response" | awk '{print $4}')
AWS_SESSION_TOKEN=$(echo "$aws_response" | awk '{print $5}')

aws --profile "$PROFILE_NAME"_mfa configure set aws_access_key_id "$AWS_ACCESS_KEY"
aws --profile "$PROFILE_NAME"_mfa configure set aws_secret_access_key "$AWS_SECRET_KEY"
aws --profile "$PROFILE_NAME"_mfa configure set aws_session_token "$AWS_SESSION_TOKEN"

echo "Succesfully updated credentials file"
