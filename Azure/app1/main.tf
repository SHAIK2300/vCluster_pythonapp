module "aks" {
  source              = "../../modules/Azure/aks_cluster"
  resource_group_name = var.resource_group_name
  location            = var.location
  cluster_name        = var.cluster_name
  default_node_pool   = var.default_node_pool
  node_count          = var.node_count
  vm_size             = var.vm_size
  acr_name            = var.acr_name
}

