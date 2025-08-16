provider "aws" {
  region = "ap-south-1"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "todo-api-cluster"
  kubernetes_version = "1.27"
  vpc_id             = aws_vpc.dev_vpc.id
  subnet_ids         = [aws_subnet.dev_subnet.id, aws_subnet.public_b.id]

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      desired_size   = 2
      min_size       = 1
      max_size       = 3
    }
  }
}
