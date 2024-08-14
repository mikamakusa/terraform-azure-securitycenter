module "log_analytics" {
  source              = "git@github.com:mikamakusa/terraform-azure-log-analytics"
  resource_group_name = data.azurerm_resource_group.this.name
  workspace           = var.log_analytics_workspace
}

module "iothub" {
  source              = "git@github.com:mikamakusa/terraform-azure-iothub.git"
  resource_group_name = data.azurerm_resource_group.this.name
  iothub              = var.iothub
}