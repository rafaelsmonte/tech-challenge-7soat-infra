# Maintenance

This file contains instructions for maintenance activities on infrastructure

## Terraform

- **Import terraform object**
  - `terraform import -var-file values.tfvars module.<module-name>.<resource>.<resource_id> <resource-id-on-aws>`

## Database

- **Connection to database**
    - Run the `k8s/global/2-database-proxy.yaml` pod;
    - Setup the container connection dns on the nginx config file;
    - Connection with `payments-service database` set up the `payments-service database` on nginx config file and run `kubectl port-forward pod/nginx-rds-proxy 55432:55432`
      - You can connect with database through `localhost:55432` and the database credentials