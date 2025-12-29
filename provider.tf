terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }
}

provider "azurerm" {
  
  features {}
  subscription_id = "8b0422c9-d3b4-4ad5-b676-1cd162a61f87"
}