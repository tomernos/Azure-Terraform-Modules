#!/bin/bash

echo "🔄 Copying backend config..."
cp ../../terraform-config/backend/dev/northeurope/backend-config.tfvars backend-config.tfvars

echo "🚀 Running terraform init..."
terraform init \
  -backend-config=backend-config.tfvars \
  -reconfigure

echo "🧪 Validating Terraform configuration..."
terraform validate

echo "📋 Running terraform plan..."
terraform plan -out=tfplan.out

echo "✅ Running terraform apply..."
terraform apply tfplan.out

echo "🧹 Cleaning up temporary files..."
rm backend-config.tfvars tfplan.out