module "log_analytics" {
  source              = "modules/terraform-azure-log-analytics"
  resource_group_name = data.azurerm_resource_group.this.name
  workspace           = var.log_analytics_workspace
}

module "iothub" {
  source              = "modules/terraform-azure-iothub"
  resource_group_name = data.azurerm_resource_group.this.name
  iothub              = var.iothub
}