resource_group_name="deleteme-gwlb-demo"
location="koreacentral"

networking_object                 = {
  vnet = {
      name                = "-vnet"
      address_space       = ["172.16.10.0/24"]
      dns                 = []
  }
  specialsubnets = {
  }

  subnets = {
    snet-backend = {
      name                = "snet-backend"
      cidr                = "172.16.10.0/25"
      service_endpoints   = []
      nsg_name            = "nsg-fortigate"
    }
    snet-management = {
      name                = "snet-management"
      cidr                = "172.16.10.128/25"
      service_endpoints   = []
      nsg_name            = "nsg-fortigate"
    }
 
  }
}

custom_data = "cloud_init.txt"

pip_management = {
  0               = {
    name          = "pip-forti0"
  }
  1               = {
    name          = "pip-forti1"
  }
}

fortigate = {
  name          = "fortigate"

  vm_num        = 2
  vm_size       = "Standard_F4s_v2"
    
  subnet        = "snet-backend"
  subnet_ip_offset  = 4
  
  vm_publisher      = "fortinet"
  vm_offer          = "fortinet_fortigate-vm_v5"
  vm_sku            = "fortinet_fg-vm_payg_20190624"
  vm_version        = "latest" 
}

admin_username="azureuser"
admin_password="enteradminpasswordhere"
