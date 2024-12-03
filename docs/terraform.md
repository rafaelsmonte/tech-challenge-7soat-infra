# Kubernetes Infra Setup Deployment

```
Requirements:
  - Terraform CLI configured in your operating system and propper AWS credencials for terraform from cloud infrastructure
  - Database infrastruture properly created
  - Make sure the VPC and public and private subnets are created and their ID's on AWS properly set on terraform env vars (values.tfvars)
```

1. Create IAM user for AWS CLI and Kubectl Usage with the following permissions:
```
1. AmazonEKSClusterPolicy
2. AmazonEKSServicePolicy
3. Custon Inline Policy. Suggested name: EKSCLIAccessPolicy

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:CreateCluster",
                "eks:DeleteCluster",
                "eks:DescribeCluster",
                "eks:ListClusters",
                "eks:UpdateClusterConfig",
                "eks:UpdateClusterVersion",
                "eks:CreateNodegroup",
                "eks:UpdateNodegroupConfig",
                "eks:DeleteNodegroup",
                "eks:DescribeNodegroup",
                "eks:ListNodegroups",
                "iam:PassRole",
                "iam:GetRole",
                "ec2:DescribeKeyPairs"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ecr:CreateRepository",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:DescribeImages",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:GetAuthorizationToken"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:GetOpenIDConnectProvider",
                "iam:CreateOpenIDConnectProvider",
                "iam:TagOpenIDConnectProvider",
                "iam:CreateRole",
                "eks:TagResource",
                "cloudformation:ListStacks",
                "cloudformation:CreateStack",
                "iam:*"
            ],
            "Resource": "*"
        }
    ]
}
```

2. Create ROLE for AWS EKS and AWS EKS Node Group:
```
1. AWS_EKS_ROLE

  1.1. AmazonEKSClusterPolicy
  1.2. Custom Inline Permission. Suggested name: AWSEKSExtraPermissions

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:DescribeCluster",
                "eks:ListClusters",
                "eks:CreateNodegroup",
                "eks:UpdateNodegroupConfig",
                "eks:DeleteNodegroup",
                "eks:DescribeNodegroup",
                "eks:ListNodegroups",
                "eks:UpdateClusterConfig",
                "eks:UpdateClusterVersion"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:PassRole"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "servicequotas:ListServiceQuotas",
                "servicequotas:GetServiceQuota",
                "servicequotas:RequestServiceQuotaIncrease"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetSecretValue",
                "secretsmanager:ListSecrets"
            ],
            "Resource": "*"
        }
    ]
}

2. AWS_EKS_NODE_GROUP_ROLE

  2.1. AmazonEC2ContainerRegistryReadOnly
  2.2. AmazonEKS_CNI_Policy
  2.3. AmazonEKSWorkerNodePolicy
  2.4. Custom Inline Permission. Suggested name: EKSExtraPermissions

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateVolume",
                "ec2:AttachVolume",
                "ec2:DeleteVolume",
                "ec2:DescribeVolumes",
                "ec2:DescribeVolumeStatus",
                "ec2:DescribeInstances",
                "ec2:DetachVolume",
                "ec2:CreateSnapshot",
                "ec2:DeleteSnapshot",
                "ec2:DescribeSnapshots",
                "ec2:ModifyVolume",
                "ec2:CreateTags"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetSecretValue",
                "secretsmanager:ListSecrets"
            ],
            "Resource": "*"
        },
        {
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
```

3. Install necessary dependencies for AWS CLI
```
./infra/scripts/eks-cluster-deploy.sh setup-env
```

4. Configure AWS credentials for user created on step 1
```
./infra/scripts/eks-cluster-deploy.sh setup-aws-auth
```

5. Update kubectl config to reference EKS cluster
```
./infra/scripts/eks-cluster-deploy.sh update-kubeconfig
```

6. Create ECR repository
```
terraform apply -var-file values.tfvars -target module.ecr
```

7. Create SQS and SNS resources
```
terraform apply -var-file values.tfvars -target module.sns-sqs
```

8. Create cognito
```
terraform apply -var-file values.tfvars -target module.cognito
```

9. Create lambda
```
// Make sure to setup the lambda_function_filename env var to point to a local lambda .zip file
terraform apply -var-file values.tfvars -target module.lambda
```

10. Create EKS infra
```
terraform apply -var-file values.tfvars -target module.kubernetes-infra
```

11. Install kubernetes 'drivers'
```
terraform apply -var-file values.tfvars -target module.kubernetes-drivers
```

12.  Create api-gateway
```
terraform apply -var-file values.tfvars -target module.api-gateway
```