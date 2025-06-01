# Defining input variables for the APIM module
variable "apim_name" {
  description = "The name of the API Management service"
  type        = string
}

variable "location" {
  description = "The Azure region for the API Management service"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "publisher_name" {
  description = "The name of the publisher"
  type        = string
}

variable "publisher_email" {
  description = "The email address of the publisher"
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the API Management service (e.g., Developer, Standard, Premium)"
  type        = string
  default     = "Developer"
}

variable "sku_capacity" {
  description = "The capacity (number of units) for the SKU"
  type        = number
  default     = 1
}

variable "virtual_network_type" {
  description = "The type of virtual network integration (None, External, Internal)"
  type        = string
  default     = "None"
}

variable "subnet_id" {
  description = "The subnet ID for virtual network integration (required if virtual_network_type is not None)"
  type        = string
  default     = null
}

variable "enable_http2" {
  description = "Enable HTTP/2 protocol for the API Management service"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "additional_locations" {
  description = "List of additional locations for the API Management service (Premium SKU only)"
  type = list(object({
    location             = string
    capacity             = number
    virtual_network_type = string
    subnet_id            = string
    gateway_disabled     = bool
  }))
  default = []
}

variable "delegation_enabled" {
  description = "Enable delegation for authentication"
  type        = bool
  default     = false
}

variable "delegation_url" {
  description = "The URL for delegation (required if delegation_enabled is true)"
  type        = string
  default     = null
}

variable "delegation_validation_key" {
  description = "The validation key for delegation (optional)"
  type        = string
  default     = null
}

variable "delegation_subscriptions_enabled" {
  description = "Enable delegation for subscriptions"
  type        = bool
  default     = true
}

variable "delegation_user_registration_enabled" {
  description = "Enable delegation for user registration"
  type        = bool
  default     = true
}

variable "min_api_version" {
  description = "The minimum API version supported by the API Management service"
  type        = string
  default     = null
}