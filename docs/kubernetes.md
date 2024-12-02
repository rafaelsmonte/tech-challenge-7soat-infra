# Kubernetes Infra Setup Deployment

```
Requirements:
  - Kubernetes Infra Setup Deployment must have been executed through terraform (see: terraform.md for more information) 
  - Each "application" has its folder and the kubernetes resources are ordered. The deploy of each resource must
    follow the order
  - Bellow are the order in which each resource must be deployed
```

## Deploy Application on Kubernetes

1. Deploy Global Resources

```
// Secrets store that maps to AWS secrets store
// It is necessary to install propper kubernetes drives see: terraform/modules/kubernetes-drivers
kubectl apply -f k8s/global/1-secrets-store.yaml

// (Optional) A pod running nginx as a reverse proxy to the relational databases for troubleshooting
// Needs to set up database private uri on ngin config
kubectl apply -f k8s/global/2-database-proxy.yaml
```

2. Deploy Products Catalog Service

```
kubectl apply -f k8s/products-catalog-service
```

3. Deploy Payments Service

```
kubectl apply -f k8s/payments-service
```

4. Deploy Orders Service

```
kubectl apply -f k8s/orders-service
```

5. Monitoring - Prometheus

```
kubectl apply -f infra/deployment/monitoring/prometheus/1-prometheus-node-exporter-daemonset.yaml
kubectl apply -f infra/deployment/monitoring/prometheus/2-prometheus-service-account.yaml
kubectl apply -f infra/deployment/monitoring/prometheus/3-prometheus-cluster-role.yaml
kubectl apply -f infra/deployment/monitoring/prometheus/4-prometheus-cluster-role-binding.yaml
kubectl apply -f infra/deployment/monitoring/prometheus/5-prometheus-config-map.yaml
kubectl apply -f infra/deployment/monitoring/prometheus/6-prometheus-dployment.yaml
kubectl apply -f infra/deployment/monitoring/prometheus/7-prometheus-service.yaml
```

6. Monitoring - Grafana

```
kubectl apply -f infra/deployment/monitoring/grafana/1-grafana-config-map.yaml
kubectl apply -f infra/deployment/monitoring/grafana/2-grafana-deployment.yaml
kubectl apply -f infra/deployment/monitoring/grafana/3-grafana-service.yaml
```

## Grafana Dashboards

 - Node Exporter Metrics: 1860
 - Node Express Metrics: 14565