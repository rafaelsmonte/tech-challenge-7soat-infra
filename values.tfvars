eks_cluster_name         = "tech-challenge-7soat"
eks_cluster_role_arn     = "arn:aws:iam::839260668425:role/AWS_EKS_ROLE"
eks_subnet_ids           = ["subnet-0d501603dbb6981a0","subnet-0628055b427ab2fe6"]
eks_security_group_ids   = ["sg-0b60838921e123654"]
ecr_repository_name      = "tech-challenge-7soat-ecr-api"
eks_node_group_name         = "tech-challenge-7soat-node-group"
eks_node_group_role         = "arn:aws:iam::839260668425:role/AWS_EKS_NODE_GROUP_ROLE"
eks_node_group_subnets      = ["subnet-0d501603dbb6981a0", "subnet-0628055b427ab2fe6"]
eks_node_group_scaling_config = {
  desired_size = 2
  max_size     = 4
  min_size     = 2
}
eks_node_group_ami_type     = "AL2_x86_64"
eks_node_group_instance_types = ["t3.medium"]
eks_node_group_capacity_type = "SPOT"
eks_node_group_disk_size    = 20
eks_node_group_access_key   = "tech-challenge-7soat-key"
