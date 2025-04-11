#azure_kubernets_values
resource_group_name = "da_aks_rsg-prd"
location            = "East US"
cluster_name        = "aks1-prd"
default_node_pool   = "default"
node_count          = "2"
vm_size             = "Standard_D2_v2"
acr_name            = "daacrprd"
