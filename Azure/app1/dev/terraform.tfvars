#azure_kubernets_values
resource_group_name = "da_aks_rsgs"
location            = "East US"
cluster_name        = "mgmt_proj_vcluster"
default_node_pool   = "default"
node_count          = "2"
vm_size             = "Standard_D2_v2"
acr_name            = "daacr1"
