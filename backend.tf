terraform {
  backend "s3" {
    bucket = "my-terraform-state-raghava"
    key    = "eks/terraform.tfstate"
    region = "ap-south-1"
    use_lockfile = true
    encrypt = true
  }
}
