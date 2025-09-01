# EKS Cluster Terraform Configuration

This repository contains Terraform configurations to deploy an Amazon EKS (Elastic Kubernetes Service) cluster with supporting infrastructure on AWS.

## Architecture

The project creates:
- VPC with public and private subnets across 3 availability zones
- EKS cluster with managed node groups
- Associated IAM roles and policies
- NAT Gateways and Internet Gateway for network connectivity

## Prerequisites

- AWS Account
- Terraform (v1.0+)
- AWS CLI configured
- GitHub Actions (for CI/CD)

## Project Structure

```
.
├── .github/workflows/         # GitHub Actions workflows
├── modules/                  # Terraform modules
│   ├── eks/                 # EKS cluster configuration
│   └── vpc/                 # VPC configuration
├── backend.tf               # S3 backend configuration
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Input variables
└── outputs.tf              # Output values
```

## Configuration

### VPC Configuration
- CIDR Block: 10.0.0.0/16
- 3 Private Subnets: 10.0.1.0/24, 10.0.2.0/24, 10.0.3.0/24
- 3 Public Subnets: 10.0.4.0/24, 10.0.5.0/24, 10.0.6.0/24
- Region: ap-south-1

### EKS Configuration
- Kubernetes Version: 1.33
- Node Groups:
  - Type: t3.medium
  - Capacity: ON_DEMAND
  - Auto-scaling: 1-4 nodes

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the changes:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

## CI/CD

This project uses GitHub Actions for CI/CD with the following workflow:
- Pull Request: Runs `terraform plan`
- Push to main: Runs `terraform apply`
- Manual triggers available for plan/apply/destroy

### Workflow Features
- Self-hosted runners
- AWS credentials via OIDC
- Plan output comments on PRs
- State stored in S3 bucket

## State Management

Terraform state is stored in an S3 bucket:
- Bucket: my-terraform-state-surya
- Key: eks/terraform.tfstate
- Region: ap-south-1
- Encryption enabled
- State locking enabled

## Outputs

- `cluster_endpoint`: EKS cluster endpoint URL
- `cluster_name`: Name of the EKS cluster
- `vpc_id`: ID of the created VPC

## Cleanup

To destroy all resources:
```bash
terraform destroy
```

## Security Notes

- Private subnets are used for EKS nodes
- IAM roles follow least privilege principle
- VPC endpoints can be added as needed
- Encryption enabled for state storage