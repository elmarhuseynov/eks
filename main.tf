provider "aws"
{
  region = "us-west-2"
}

module "vpc"
{
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "eks"
{
  source = "terraform-aws-modules/eks/aws"

  cluster_name = "eks-cluster"
  subnets      = module.vpc.private_subnets

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}