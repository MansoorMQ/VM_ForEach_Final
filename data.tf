data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = "B17_KeyVault"
  #resource_group_name = values(var.rgs)[0].rg_name
}

data "azurerm_key_vault_secret" "username" {
  for_each     = var.vms
  name         = each.value.usernamesecret
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "password" {
  for_each     = var.vms
  name         = each.value.passwordsecret
  key_vault_id = data.azurerm_key_vault.kv.id
}