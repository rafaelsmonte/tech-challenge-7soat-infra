#============================================================================
# Author: Thiago, Vitor, Rafael
# Description: Creates Kubernetes Infrastructure
#============================================================================
resource "aws_eks_cluster" "eks_cluster_tech_challenge_7soat" {
  name     = var.eks_cluster_name
  role_arn = var.eks_cluster_role_arn

  vpc_config {
    subnet_ids         = var.eks_subnet_ids
    security_group_ids = var.eks_security_group_ids
  }
}

resource "aws_eks_node_group" "eks_node_group_tech_challenge_7soat" {
  cluster_name    = var.eks_cluster_name
  node_group_name = var.eks_node_group_name
  node_role_arn   = var.eks_node_group_role
  subnet_ids      = var.eks_node_group_subnets
  scaling_config {
    desired_size = var.eks_node_group_scaling_config.desired_size
    max_size     = var.eks_node_group_scaling_config.max_size
    min_size     = var.eks_node_group_scaling_config.min_size
  }
  instance_types  = var.eks_node_group_instance_types
  ami_type        = var.eks_node_group_ami_type
  capacity_type   = var.eks_node_group_capacity_type
  disk_size       = var.eks_node_group_disk_size
  remote_access {
    ec2_ssh_key = var.eks_node_group_access_key
  }
  depends_on = [aws_eks_cluster.eks_cluster_tech_challenge_7soat]
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster_tech_challenge_7soat.endpoint
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.eks_cluster_tech_challenge_7soat.arn
}