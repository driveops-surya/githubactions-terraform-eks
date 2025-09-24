# Terraform EKS Configuration

This directory contains the complete Terraform configuration for deploying an Amazon EKS (Elastic Kubernetes Service) cluster with supporting infrastructure on AWS.

## Architecture Overview

This terraform configuration creates:

- **VPC Infrastructure**: 
  - VPC with DNS support and hostnames enabled
  - 3 Public subnets across different availability zones
  - 3 Private subnets across different availability zones
  - Internet Gateway for public internet access
  - NAT Gateways for private subnet internet access
  - Route tables for proper traffic routing

- **EKS Cluster**:
  - Managed EKS cluster with specified Kubernetes version
  - IAM roles and policies for cluster operation
  - Security groups for network access control

- **EKS Node Groups**:
  - Managed node groups for worker nodes
  - Auto-scaling configuration
  - IAM roles and policies for node operation

## Configuration Files

- `main.tf`: Main configuration file that orchestrates VPC and EKS modules
- `variables.tf`: Input variables for customizing the deployment
- `outputs.tf`: Output values exposed after deployment
- `backend.tf`: S3 backend configuration for state management
- `modules/`: Directory containing reusable terraform modules
  - `modules/vpc/`: VPC and networking resources
  - `modules/eks/`: EKS cluster and node group resources

## Usage

1. Initialize Terraform to download required providers and modules:
```bash
terraform init
```

2. Review the planned changes:
```bash
terraform plan
```

3. Apply the configuration to create resources:
```bash
terraform apply
```

4. Clean up resources when no longer needed:
```bash
terraform destroy
```

## Default Configuration

- **Region**: ap-south-1 (Mumbai)
- **VPC CIDR**: 10.0.0.0/16
- **Kubernetes Version**: 1.33
- **Node Type**: t3.medium
- **Node Scaling**: 1-4 nodes (desired: 2)
- **Capacity Type**: ON_DEMAND

## Customization

You can customize the deployment by modifying variables in `variables.tf` or by passing variables during terraform commands:

```bash
terraform plan -var="cluster_name=my-cluster" -var="cluster_version=1.32"
```

## State Management

This configuration uses S3 backend for storing terraform state, ensuring:
- Shared state across team members
- State locking to prevent conflicts
- State encryption for security

## Outputs

After successful deployment, the following outputs are available:
- `cluster_endpoint`: EKS cluster API endpoint
- `cluster_name`: Name of the created EKS cluster
- `vpc_id`: ID of the created VPC

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform v1.0 or higher
- Appropriate AWS IAM permissions for creating EKS, VPC, and IAM resources