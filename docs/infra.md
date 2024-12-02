# Infrastructure

## Overview

<center><img src='./img/infra_architecture.png'></center>

<br>

- The infrastructure is deployed on AWS EKS.
- There is a VPC configured with 4 subnets: 2 public and 2 private.
- The Kubernetes cluster is in the 2 public subnets.
- The Services RDS Databases are in the 2 private subnets so that there is no way to have public access to it through the internet.
- Order, Payments and Products Catalog services deployed as pods on kubernetes;
- Customer authenticator deployed as a lambda function integrated with AWS cognito;
- Monitoring with grafana and prometheus and HPA + cluster-autoscaler for horizontal scaling;
- Asyncrhonous messaging with SNS+SQS;
- All infrastructure managed through terraform;

## Services
- **Payments Service**
  - Secrets from AWS secrets manager
  - Service docker image on amazon ECR
  - HPA to scale up to 10 containers
  - Integration with Mercado Pago as the payment broker
  - IAC at `k8s/payments-service`
  - 1 Relational Database on RDS
  - 1 SNS topic to publish async messages
  - Cluter ip service to allow private api calls and prometheus service discovery
- **Orders Service**
  - Secrets from AWS secrets manager
  - Service docker image on amazon ECR
  - HPA to scale up to 10 containers
  - IAC at `k8s/orders-service`
  - 1 NoSql table on dynamoDB
  - 1 SQS queue to receive messages
  - Cluter ip service to allow prometheus service discovery
- **Products Catalog Service**
  - Secrets from AWS secrets manager
  - Service docker image on amazon ECR
  - HPA to scale up to 10 containers
  - IAC at `k8s/products-catalog-service`
  - 1 Relational Database on RDS
  - 1 SQS queue to receive messages
  - Cluter ip service to allow private api calls and prometheus service discovery

## Monitoring
  - 1 Grafana pod instance.
  - 1 Prometheus pod instance.
  - Both use `emptyDir` for disk storage but can be evolved to use EBS for persistent data storage.
  - Node Exporter installed on each VM to monitor VM resources.

## Kube-system:
  - Some auxiliary services are installed in the kube-system namespace.
  - The Cluster Autoscaler monitors cluster compute resources and adjusts the AWS Auto Scaling Group to scale the cluster up and down according to resource usage.
  - Metrics Server allows HPA to monitor API pod resource usage and scale it up or down horizontally.

## External Services:
  - Mercado Pago: We use Mercado Pago to facilitate payments via Pix.


