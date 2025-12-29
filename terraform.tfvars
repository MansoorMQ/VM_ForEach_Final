key_vault_name = "B17G30"

rgs = {
    rg1 = {
     rg_name     = "rg_mq1"
     rg_location = "Australia East"
     vnet_name = "vnet1"
     address_space = ["10.0.0.0/16"]
  }   
} 
    #rg2 = {
     # rg_name     = "MQ_Prod2"
     # rg_location = "West US"
    #}
 
    #rg3 = {
     # rg_name     = "MQ_Prod3"
      #rg_location = "Central US"
    #}
#}

vms = {
    frontendvm = {
      vnet_name = "vnet1"
      #address_space = ["10.0.0.0/16"]
      subnet_name = "subnet1"
      address_prefixes = ["10.0.1.0/24"]
      rg_name     = "rg_mq1"
      rg_location = "Australia East"
      nic_name    = "nic1"
      pip_name    = "pip1"
      vm_name     = "vm1"
      vm_size    = "Standard_B2ats_v2"
      usernamesecret = "fendusername"
      passwordsecret = "fvmpassword"

     # admin_username = "Mansoor"
    #  admin_password = "P@ssw0rd1234"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
     
      
    }
     backendvm = {
      vnet_name = "vnet1"
      #address_space = ["10.0.0.0/16"]
      subnet_name = "subnet2"
      address_prefixes = ["10.0.2.0/24"]
      rg_name     = "rg_mq1"
      rg_location = "Australia East"
      nic_name    = "nic2"  
      pip_name    = "pip2"
      vm_name     = "vm2"
      vm_size    = "Standard_B2ats_v2"
      usernamesecret = "bendusername"
      passwordsecret = "bvmpassword"
    
      #admin_username = "Zeeshan"
      #admin_password = "P@ssw0rd1234"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
   
}


