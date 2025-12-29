resource "azurerm_resource_group" "MQ1" {
  for_each = var.rgs
  name     = each.value.rg_name
  location = each.value.rg_location
}

resource "azurerm_virtual_network" "vnet1" {
  depends_on          = [azurerm_resource_group.MQ1]  # explicit dependacy #
  for_each            = var.rgs
  name                = each.value.vnet_name
  location            = each.value.rg_location
  resource_group_name = each.value.rg_name
  address_space       = each.value.address_space
  }

  resource "azurerm_subnet" "subnet" {
  depends_on         = [azurerm_virtual_network.vnet1]
  for_each           = var.vms
  resource_group_name  = each.value.rg_name
  virtual_network_name = each.value.vnet_name
  name               = each.value.subnet_name
  address_prefixes   = each.value.address_prefixes
  }

output "subnetmq" {
  value = values(azurerm_subnet.subnet)[*].id
}
  
resource "azurerm_network_interface" "nic" {
  depends_on          = [azurerm_subnet.subnet]
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.rg_location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
  }

  resource "azurerm_public_ip" "pip" {
  for_each            = var.vms
  depends_on          = [azurerm_network_interface.nic]
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
  location            = each.value.rg_location
  allocation_method   = "Static"
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = var.vms
  depends_on          = [azurerm_public_ip.pip]
  name                = each.value.vm_name
  resource_group_name = each.value.rg_name
  location            = each.value.rg_location
  size                = each.value.vm_size
  admin_username      = data.azurerm_key_vault_secret.username[each.key].value
  admin_password      = data.azurerm_key_vault_secret.password[each.key].value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

    os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}