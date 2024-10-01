# 7 Soat Infrastructure

This repository contains IaC terraform manifest to create the necessary infrastruture on AWS for 7Soat application.

    - **add-ons:** Contains kubernetes cluster configuration files for nodegroups ASG autoscaler
    - **modules/api-gateway:** Contains the IaC files for aws api gateway deployment
    - **modules/cognito:** Contains the IaC for aws cognito service
    - **modules/kubernetes-drivers:** Contains the IaC to run the kubernetes add-ons files and install helm packages
    - **modules/kubernetes-infra:** Contains the IaC to run the kubernetes infrastructure
    - **modules/kubernetes-infra:** Contains the IaC to run the lambda infrastructure
