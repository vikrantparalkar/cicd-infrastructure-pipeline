provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    "Name" = "${var.cluster_name}-vpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.0.0"
  

  name            = var.cluster_name
 
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id


  create_iam_role = false
  iam_role_arn    = aws_iam_role.eks_cluster.arn


  eks_managed_node_groups = {
    ng-default = {
      desired_capacity = var.node_group_desired
      max_capacity     = var.node_group_desired + 1
      min_capacity     = 1
      instance_types   = var.node_group_instance_types
      key_name         = null
      disk_size        = 20
      subnets          = module.vpc.private_subnets
      iam_role_arn     = aws_iam_role.eks_node.arn
      tags = {
        "Name" = "${var.cluster_name}-ng"
      } 
    }
  }


  tags = {
    "Name" = var.cluster_name
  }
}
