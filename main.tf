terraform {
  backend "s3" {
    bucket = "tech-challenge-7soat-infra-terraform-state"
    key    = "eks-cluster/terraform.tfstate"
    region = "us-east-1"
    profile = "default"
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "aws_ecr_repository" "ecr_repository_tech_challenge_7soat" {
  name = var.ecr_repository_name
}

module "kubernetes_infra" {
  source = "./modules/kubernetes-infra"
  eks_cluster_name = var.eks_cluster_name
  eks_cluster_role_arn = var.eks_cluster_role_arn
  eks_subnet_ids = var.eks_subnet_ids
  eks_security_group_ids = var.eks_security_group_ids
  eks_node_group_name = var.eks_node_group_name
  eks_node_group_role = var.eks_node_group_role
  eks_node_group_subnets = var.eks_node_group_subnets
  eks_node_group_scaling_config = var.eks_node_group_scaling_config
  eks_node_group_instance_types = var.eks_node_group_instance_types
  eks_node_group_ami_type = var.eks_node_group_ami_type
  eks_node_group_capacity_type = var.eks_node_group_capacity_type
  eks_node_group_disk_size = var.eks_node_group_disk_size
  eks_node_group_access_key = var.eks_node_group_access_key
  
  depends_on = [resource.aws_ecr_repository.ecr_repository_tech_challenge_7soat]
}

module "kubernetes_drivers" {
  source = "./modules/kubernetes-drivers"
  depends_on = [module.kubernetes_infra]
}
