#!/bin/bash

# Builds and deploys the docker container to the ECR repo

export set AWS_ACCOUNT_ID=`aws sts get-caller-identity |grep Account |awk '{print $2}'|colrm 15| tr -d '"'`
export set AWS_REGION=`aws configure get region`

echo "Checking ECR Repository s3-copy  - will create if needed."

aws ecr describe-repositories --repository-names s3-copy || aws ecr create-repository --repository-name s3-copy

echo "Building s3-copy docker container..."

docker build -t s3-copy .
docker tag s3-copy:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/s3-copy

echo "Logging into ECR for $AWS_ACCOUNT_ID in region $AWS_REGION"
## Login to the ECR repository - set your own region
$(aws ecr get-login --no-include-email --region $AWS_REGION)

docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/s3-copy:latest




