# vCluster_pythonapp
created for POC on vCluster with Githubactions.
used for creating cred in githubactios
<!-- az ad sp create-for-rbac --name github-actions --role contributor --scopes /subscriptions/b8248299-e63a-7s8h5a8i6k-417a-a335-5d3c87fa9990/resourceGroups/da_aks_rsg -->
For GitHub Actions to work, you need to add these secrets in GitHub → Settings → Secrets → Actions:

Secret Name	How to Get It
AZURE_CREDENTIALS	Run az ad sp create-for-rbac --name github-actions --role contributor --scopes /subscriptions/<SUBSCRIPTION_ID>/resourceGroups/<RESOURCE_GROUP> and paste the JSON output
AKS_RESOURCE_GROUP	Your AKS resource group name (e.g., my-resource-group)
AKS_CLUSTER_NAME	Your AKS cluster name (e.g., my-aks-cluster)
DOCKER_HUB_USERNAME	Your Docker Hub username
DOCKER_HUB_TOKEN	Docker Hub access token (from account settings)


FOR AZURE_CREDENTIALS
# 1. Login to Azure (will open browser)
az login

# 2. Set the correct subscription (replace with your subscription ID)
az account set --subscription "<b8248299-e63a-7s8h5a8i6k-417a-a335-5d3c87fa9990>"

# 3. Delete old service principal if exists (replace with your appId)
az ad sp delete --id "f7e51d53-2cab-4419-bf8a-c0ifm6r5aan9a05eb"

# 4. Create new service principal with proper format
$credentials = az ad sp create-for-rbac `
  --name "github-actions-vcluster" `
  --role "contributor" `
  --scopes "/subscriptions/b8248299-e63a-7s8h5a8i6k-417a-a335-5d3c87fa9990/resourceGroups/da_aks_rsg" `
  --sdk-auth

# 5. Display the credentials (save this output!)
$credentials | ConvertFrom-Json | ConvertTo-Json -Depth 10