# 7 Soat Infrastructure

This repository contains IaC terraform manifest to create the necessary infrastruture on AWS for 7Soat application.

## Summary

- [General infrastructure information](docs/infra.md)
- [Infrastructure deployment on AWS - Terraform](docs/terraform.md)
- [Kubernetes resources deployments](docs/kubernetes.md)
- [Maintenance](docs/maintenance.md)

## Folder Structure

- **k8s**
    - **global:** Contains general purpose resources (pods, secrets store)
    - **monitoring:** Contains prometheus and grafana config
    - **orders-service:** Contains orders service deployment
    - **payments-service:** Contains payments service deployment
    - **products-catalog-service:** Contains products catalog service deployment

- **terraform**
    - **add-ons:** Contains kubernetes cluster configuration files for nodegroups ASG autoscaler
    - **modules/api-gateway:** Contains the IaC files for aws api gateway deployment
    - **modules/cognito:** Contains the IaC for aws cognito service
    - **modules/ecr:** Contains the IaC for aws private repositories for docker images of 7soat project services
    - **modules/kubernetes-drivers:** Contains the IaC to run the kubernetes add-ons files and install helm packages
    - **modules/kubernetes-infra:** Contains the IaC to run the kubernetes infrastructure
    - **modules/lambda:** Contains the IaC to run the lambda infrastructure
    - **modules/sns-sqs:** Contains the IaC for SNS and SQS for assynchronous messages
