# Configure suas credenciais do Azure usando o Azure CLI ou outro método suportado
provider "azurerm" {
  features {}
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "apim-rg" {
  name     = "rg-apim"
  location = "eastus2"
}

# Crie o Azure API Management
resource "azurerm_api_management" "fabioapim" {
  name                = "fabioapim"
  location            = azurerm_resource_group.apim-rg.location
  resource_group_name = azurerm_resource_group.apim-rg.name
  sku_name            = "Premium_1"
  publisher_name      = "Fábio"
  publisher_email     = "fabio@fabiojoao.com.br"
}

# Crie as quatro APIs dentro do Azure API Management
resource "azurerm_api_management_api" "argentina" {
  name                = "apimla"
  display_name        = "API da Argentina"
  api_management_name = azurerm_api_management.fabioapim.name
  resource_group_name = azurerm_resource_group.apim-rg.name
  path                = "mla"
  protocols           = ["http", "https"]
  revision            = "1"
}

resource "azurerm_api_management_api" "brasil" {
  name                = "apimlb"
  display_name        = "API do Brasil"
  api_management_name = azurerm_api_management.fabioapim.name
  resource_group_name = azurerm_resource_group.apim-rg.name
  path                = "mlb"
  protocols           = ["http", "https"]
  revision            = "1"
}

resource "azurerm_api_management_api" "colombia" {
  name                = "apimlc"
  display_name        = "API da Colômbia"
  api_management_name = azurerm_api_management.fabioapim.name
  resource_group_name = azurerm_resource_group.apim-rg.name
  path                = "mlc"
  protocols           = ["http", "https"]
  revision            = "1"
}


resource "azurerm_api_management_api" "mexico" {
  name                = "apimlm"
  display_name        = "API do México"
  api_management_name = azurerm_api_management.fabioapim.name
  resource_group_name = azurerm_resource_group.apim-rg.name
  path                = "mlm"
  protocols           = ["http", "https"]
  revision            = "1"
}

# Política de API para Argentina
resource "azurerm_api_management_api_policy" "argentina_policy" {
  api_name            = azurerm_api_management_api.argentina.name
  api_management_name = azurerm_api_management.fabioapim.name
  resource_group_name = azurerm_resource_group.apim-rg.name
  xml_content         = file("${path.module}/policies.xml")
}

# Política de API para Brasil
resource "azurerm_api_management_api_policy" "brasil_policy" {
  api_name            = azurerm_api_management_api.brasil.name
  api_management_name = azurerm_api_management.fabioapim.name
  resource_group_name = azurerm_resource_group.apim-rg.name
  xml_content         = file("${path.module}/policies.xml")
}

# Política de API para Colômbia
resource "azurerm_api_management_api_policy" "colombia_policy" {
  api_name            = azurerm_api_management_api.colombia.name
  api_management_name = azurerm_api_management.fabioapim.name
  resource_group_name = azurerm_resource_group.apim-rg.name
  xml_content         = file("${path.module}/policies.xml")
}

# Política de API para México
resource "azurerm_api_management_api_policy" "mexico_policy" {
  api_name            = azurerm_api_management_api.mexico.name
  api_management_name = azurerm_api_management.fabioapim.name
  resource_group_name = azurerm_resource_group.apim-rg.name
  xml_content         = file("${path.module}/policies.xml")
}