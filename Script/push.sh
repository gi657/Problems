#!/bin/bash
ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
REGION_CODE="ap-northeast-2"
ECR_NAME="wsi-app-repo"
IMAGE_URL=$ACCOUNT_ID.dkr.ecr.$REGION_CODE.amazonaws.com/$ECR_NAME
IMAGE_TAG="love"

# Install Docker
sudo dnf install -y docker
sudo systemctl enable --now docker
sudo usermod -aG docker ec2-user
sudo usermod -aG docker root
sudo chmod 666 /var/run/docker.sock

# Docker
aws ecr get-login-password --region $REGION_CODE | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION_CODE.amazonaws.com
docker build -t $IMAGE_URL:$IMAGE_TAG .
docker push $IMAGE_URL:$IMAGE_TAG
