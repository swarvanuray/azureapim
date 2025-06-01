# Defining the Azure API Management resource
resource "azurerm_api_management" "apim" {
  name                = var.apim_name
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = "${var.sku_name}_${var.sku_capacity}"

  # Configuring virtual network integration (optional)
  virtual_network_type = var.virtual_network_type

  dynamic "virtual_network_configuration" {
    for_each = var.virtual_network_type != "None" ? [1] : []
    content {
      subnet_id = var.subnet_id
    }
  }

  # Configuring additional locations (optional, for Premium SKU)
  dynamic "additional_location" {
    for_each = var.additional_locations
    content {
      location = additional_location.value.location
      capacity = additional_location.value.capacity

      dynamic "virtual_network_configuration" {
        for_each = try(additional_location.value.virtual_network_type, "None") != "None" ? [1] : []
        content {
          subnet_id = additional_location.value.subnet_id
        }
      }

      gateway_disabled = additional_location.value.gateway_disabled
    }
  }

  # Configuring delegation settings (optional)
  dynamic "sign_up" {
    for_each = var.delegation_enabled ? [1] : []
    content {
      enabled = true
      terms_of_service {
        enabled = true
        consent_required = true
        text = "Please accept the terms of service"
      }
      
      #dynamic "delegation" {
      #  for_each = var.delegation_enabled ? [1] : []
      #  content {
      #    url                      = var.delegation_url
      #    validation_key           = var.delegation_validation_key
      #    subscriptions_enabled    = var.delegation_subscriptions_enabled
      #    user_registration_enabled = var.delegation_user_registration_enabled
      #  }
      #}
    }
  }

  # HTTP/2 is configured at the API level via protocols

  # Setting minimum API version (optional)
  min_api_version = var.min_api_version

  # Adding tags for resource organization
  tags = var.tags
}

# Defining an example API (optional, can be extended)
#resource "azurerm_api_management_api" "example_api" {
  #name                = "${var.apim_name}-example-api"
  #resource_group_name = var.resource_group_name
  #api_management_name = azurerm_api_management.apim.name
  #revision            = "1"
  #display_name        = "Example API"
  #path                = "example"
  #protocols           = ["https", "http2"]
#}

# Defining an example policy (optional)
#resource "azurerm_api_management_policy" "example_policy" {
  #api_management_name = azurerm_api_management.apim.name
  #resource_group_name = var.resource_group_name
  #xml_content         = <<XML
