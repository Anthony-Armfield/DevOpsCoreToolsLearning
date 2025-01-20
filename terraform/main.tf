provider "azurerm" {
    features {}
    subscription_id = "9ee8a468-41dd-41c1-8446-893056c760d4"
}

resource "azurerm_resource_group" "task_scheduler_rg" {
    name    = "task_scheduler_rg-dev"
    location ="East US"
}

resource "azurerm_storage_account" "task_scheduler_storage" {
  name = "taskschedstoracc123"
  resource_group_name = azurerm_resource_group.task_scheduler_rg.name
  location = azurerm_resource_group.task_scheduler_rg.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_virtual_network" "task_scheduler_vnet" {
    name = "task-scheduler-vnet"
    address_space = [ "10.0.0.0/16" ]
    location = azurerm_resource_group.task_scheduler_rg.location
    resource_group_name = azurerm_resource_group.task_scheduler_rg.name
}

resource "azurerm_subnet" "task_scheduler_subnet" {
  name = "task-scheduler-subnet"
  resource_group_name = azurerm_resource_group.task_scheduler_rg.name
  virtual_network_name = azurerm_virtual_network.task_scheduler_vnet.name
  address_prefixes = [ "10.0.1.0/24" ]
}
