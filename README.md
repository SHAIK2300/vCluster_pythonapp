
# vCluster Python App POC

A proof-of-concept for deploying Python applications to virtual clusters (vClusters) in Azure Kubernetes Service (AKS) using GitHub Actions.

## 📌 Prerequisites

- Azure account with Owner/Contributor permissions
- AKS cluster running Kubernetes 1.22+
- Docker Hub account (or other container registry)
- GitHub repository
- Terraform

## 🔐 Terraform apply for creating cluster
```
# Login to Azure
az login
az account set --subscription <subscription_id>
```

1. Basic Command with Variable File
```
terraform apply -var-file="dev/terraform.tfvars"
```

2. Recommended Workflow
File Structure
```
terraform/
├── main.tf
├── variables.tf
└── dev/
    ├── terraform.tfvars
    └── backend.tfvars  # Optional for backend config
```

## 🔐 Azure Service Principal Setup

### Required Roles
1. **Contributor** (Subscription level)
2. **Azure Kubernetes Service Cluster User Role**
3. **Azure Kubernetes Service RBAC Admin** (Optional, for RBAC management)

### Create Service Principal
```powershell
# Login to Azure
az login

# Set active subscription
az account set --subscription "b8248299-e63a-417a-a335-5d3c87fa9990"

# Create service principal with least privileges
az ad sp create-for-rbac \
  --name "github-actions-vcluster" \
  --role "contributor" \
  --scopes "/subscriptions/b8248299-e63a-417a-a335-5d3c87fa9990/resourceGroups/da_aks_rsg" \
  --sdk-auth
```

## 🔧 GitHub Secrets Configuration

| Secret Name            | Description                                                                 | How to Obtain |
|------------------------|-----------------------------------------------------------------------------|---------------|
| `AZURE_CREDENTIALS`    | Azure service principal credentials                                         | JSON output from `az ad sp create-for-rbac` |
| `AKS_RESOURCE_GROUP`   | Name of your AKS resource group                                            | `az group list` |
| `AKS_CLUSTER_NAME`     | Name of your AKS cluster                                                   | `az aks list` |
| `DOCKER_HUB_USERNAME`  | Docker Hub username                                                        | Docker Hub account |
| `DOCKER_HUB_TOKEN`     | Docker Hub access token                                                    | Docker Hub → Account Settings → Security |

## 🚀 Deployment Workflow

1. **CI Pipeline**:
   - Builds Docker image
   - Pushes to container registry
   - Runs unit tests

2. **CD Pipeline**:
   - Creates/connects to vCluster
   - Deploys Helm chart
   - Verifies deployment

```yaml
- name: Create vCluster
  run: |
    mkdir -p /tmp/vcluster-workdir
    cd /tmp/vcluster-workdir
    vcluster create my-vcluster -n vcluster-namespace --connect=false
```

## 🔍 Troubleshooting Guide

### Common Issues
1. **Permission Errors**:
   ```bash
   az role assignment create \
     --assignee <service-principal-id> \
     --role "Azure Kubernetes Service Cluster User Role" \
     --scope "/subscriptions/<subscription-id>"
   ```

2. **Port Conflicts**:
   ```bash
   # Find and kill process using port
   netstat -ano | findstr :8080
   taskkill /PID <pid> /F
   ```

3. **vCluster Creation Failures**:
   ```bash
   vcluster delete my-vcluster -n vcluster-namespace
   kubectl delete ns vcluster-namespace
   ```

## 📂 Project Structure

```
vcluster_pythonapp/
├── .github/
│   └── workflows/
│       ├── ci.yaml
│       └── cd.yaml
├── app/
│   ├── main.py             # Flask application
│   ├── requirements.txt    # Python dependencies
│   └── Dockerfile          # Container configuration
└── charts/
    └── python-app/         # Helm chart
        ├── Chart.yaml
        ├── values.yaml
        └── templates/
            ├── deployment.yaml
            ├── service.yaml
            └── ingress.yaml
```

## 📜 Best Practices

1. **Secret Rotation**: Regenerate service principal credentials every 90 days
2. **Network Policies**: Restrict vCluster network access
3. **Monitoring**: Set up Prometheus/Grafana for vCluster observability
4. **Cleanup**: Automate vCluster deletion after testing

## 📚 Additional Resources

- [vCluster Official Documentation](https://www.vcluster.com/docs)
- [Azure RBAC Best Practices](https://docs.microsoft.com/en-us/azure/role-based-access-control/best-practices)
- [Kubernetes Production Patterns](https://github.com/kubernetes/community/blob/master/contributors/design-proposals/architecture/production-patterns.md)

- [Helm Chart Best Practices](https://helm.sh/docs/chart_best_practices/)

# 📜 EXAPMLE
## vCluster_pythonapp
created for POC on vCluster with Githubactions.
used for creating cred in githubactios
<!-- az ad sp create-for-rbac --name github-actions --role contributor --scopes /subscriptions/b8248299-e63a-7s8h5a8i6k-417a-a335-5d3c87fa9990/resourceGroups/da_aks_rsg -->
#### FOR AZURE_CREDENTIALS
### 1. Login to Azure (will open browser)
```
az login
```
### 2. Set the correct subscription (replace with your subscription ID)
```
az account set --subscription "<b8248299-e63a-7s8h5a8i6k-417a-a335-5d3c87fa9990>"
```
### 3. Delete old service principal if exists (replace with your appId)
```
az ad sp delete --id "f7e51d53-2cab-4419-bf8a-c0ifm6r5aan9a05eb"
```
### 4. Create new service principal with proper format
```
$credentials = az ad sp create-for-rbac `
  --name "github-actions-vcluster" `
  --role "contributor" `
  --scopes "/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/<RSGRP_NAME>" `
  --sdk-auth
```
### 5. Display the credentials (save this output!)
```
$credentials | ConvertFrom-Json | ConvertTo-Json -Depth 10
```