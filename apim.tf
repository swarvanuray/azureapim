# Configuring the Azure provider
provider "azurerm" {
  features {}
}

# Defining the resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "East US"
}

# Calling the APIM module with additional options
module "apim" {
  source              = "../modules/apim"
  apim_name           = "example-apim-unique-001"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  publisher_name      = "Example Publisher"
  publisher_email     = "publisher@example.com"
  sku_name            = "Premium" # Required for additional_location
  sku_capacity        = 1
  virtual_network_type = "None"
  enable_http2        = true
  min_api_version     = "2019-12-01"
  delegation_enabled   = true
  delegation_url      = "https://example.com/delegation"
  delegation_validation_key = "example-validation-key"
  delegation_subscriptions_enabled = true
  delegation_user_registration_enabled = true
  additional_locations = [
    {
      location             = "West US"
      capacity             = 1
      virtual_network_type = "None"
      subnet_id            = null
      gateway_disabled     = false
    }
  ]
  tags = {
    environment = "dev"
    project     = "example"
  }
}