locals {
  resource_group_name   = var.resource_group_name
  location              = var.location
  admin_username        = var.admin_username
  admin_password        = var.admin_password
}

resource "azurerm_resource_group" "example" {
  name     = local.resource_group_name
  location = local.location
}

module "provider_network" {
  source  = "github.com/hyundonk/terraform-azurerm-caf-virtual-network"

  prefix              = "demo"

  virtual_network_rg  = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  networking_object   = var.networking_object

  tags            = {}
}

module "pip_management" {
  source                            = "git://github.com/hyundonk/aztf-module-pip.git"

  prefix                            = "demo"
  services                          = var.pip_management

  location                          = azurerm_resource_group.example.location
  rg                                = azurerm_resource_group.example.name

  tags                              = {}
}


module "fortigate" {
  source  = "github.com/hyundonk/aztf-module-vm"

  location                          = azurerm_resource_group.example.location
  resource_group_name               = azurerm_resource_group.example.name

  instances = var.fortigate
  
  subnet_id                         = module.provider_network.subnet_ids_map[var.fortigate.subnet]
  subnet_prefix                     = module.provider_network.subnet_prefix_map[var.fortigate.subnet]

  admin_username                    = var.admin_username
  admin_password                    = var.admin_password

  custom_data                       = filebase64("config.txt")

  load_balancer_param ={
      sku             = "Gateway"
      probe_protocol  = "Tcp"
      probe_port      = 8008
      probe_interval  = 5
      probe_num       = 2
  }

  plan  = {
      name      = "fortinet_fg-vm_payg_20190624"
      product   = "fortinet_fortigate-vm_v5"
      publisher = "fortinet"
  }

  add_second_nic            = true
  subnet_id_second_nic      = module.provider_network.subnet_ids_map["snet-management"]
  subnet_prefix_second_nic  = module.provider_network.subnet_prefix_map["snet-management"]
  public_ip_id_second_nic   = [module.pip_management.public_ip.0.id, module.pip_management.public_ip.1.id]
}


