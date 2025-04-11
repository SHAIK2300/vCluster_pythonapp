# vCluster_pythonapp
created for POC on vCluster with Githubactions.
used for creating cred in githubactios
<!-- az ad sp create-for-rbac --name github-actions --role contributor --scopes /subscriptions/b8248299-e63a-417a-a335-5d3c87fa9990/resourceGroups/da_aks_rsg -->
For GitHub Actions to work, you need to add these secrets in GitHub → Settings → Secrets → Actions:

Secret Name	How to Get It
AZURE_CREDENTIALS	Run az ad sp create-for-rbac --name github-actions --role contributor --scopes /subscriptions/<SUBSCRIPTION_ID>/resourceGroups/<RESOURCE_GROUP> and paste the JSON output
AKS_RESOURCE_GROUP	Your AKS resource group name (e.g., my-resource-group)
AKS_CLUSTER_NAME	Your AKS cluster name (e.g., my-aks-cluster)
DOCKER_HUB_USERNAME	Your Docker Hub username
DOCKER_HUB_TOKEN	Docker Hub access token (from account settings)