data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_storage_account" "this" {
  count               = var.storage_account_name ? 1 : 0
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_virtual_network" "this" {
  count               = var.virtual_network_name ? 1 : 0
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_subnet" "this" {
  count                = var.subnet_name ? 1 : 0
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = data.azurerm_virtual_network.this.name
}

data "azurerm_arc_machine" "this" {
  count               = var.arc_machine_name ? 1 : 0
  name                = var.arc_machine_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_virtual_machine" "this" {
  count               = var.virtual_machine_name ? 1 : 0
  name                = var.virtual_machine_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_virtual_machine_scale_set" "this" {
  count               = var.virtual_machine_scale_set_name ? 1 : 0
  name                = var.virtual_machine_scale_set_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_eventhub_namespace" "this" {
  name                = ""
  resource_group_name = ""
}

data "azurerm_eventhub" "this" {
  name                = ""
  namespace_name      = data.azurerm_eventhub_namespace.this.name
  resource_group_name = ""
}

data "azurerm_eventhub_authorization_rule" "this" {
  eventhub_name       = data.azurerm_eventhub.this.name
  name                = ""
  namespace_name      = data.azurerm_eventhub_namespace.this.name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_logic_app_standard" "this" {
  name                = ""
  resource_group_name = ""
}