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

module "virtual_network" {
  source  = "github.com/hyundonk/terraform-azurerm-caf-virtual-network"

  prefix              = "demo"

  virtual_network_rg  = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  networking_object   = var.networking_object

  tags            = {}
}

module "pip" {
  source                            = "git://github.com/hyundonk/aztf-module-pip.git"

  prefix                            = "demo"
  services                          = var.pip

  location                          = azurerm_resource_group.example.location
  rg                                = azurerm_resource_group.example.name

  tags                              = {}
}

module "webserver" {
  source  = "github.com/hyundonk/aztf-module-vm"

  location                          = azurerm_resource_group.example.location
  resource_group_name               = azurerm_resource_group.example.name

  instances = var.webserver
  
  subnet_id                         = module.virtual_network.subnet_ids_map[var.webserver.subnet]
  subnet_prefix                     = module.virtual_network.subnet_prefix_map[var.webserver.subnet]

  admin_username                    = var.admin_username
  admin_password                    = var.admin_password

  custom_data                       = filebase64("cloud_init.txt")
  
  load_balancer_pip_id              = module.pip.public_ip.0.id

  load_balancer_param ={
      sku             = "standard"
      probe_protocol  = "Tcp"
      probe_port      = 80
      probe_interval  = 5
      probe_num       = 2
  }
}

