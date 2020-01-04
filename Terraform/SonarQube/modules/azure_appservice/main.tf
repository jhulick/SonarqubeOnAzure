resource "azurerm_app_service" "appservice" {
  name                = "${var.AppServiceName}"
  location            = "${var.location}"
  resource_group_name = "${var.resourcegroupName}"
  app_service_plan_id = "${var.AppServicePlanId}"

  site_config {
    linux_fx_version = "DOCKER|${var.ACRLoginServer}/sonarqube:v1"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = false
    "DOCKER_REGISTRY_SERVER_URL"          = "https://${var.ACRLoginServer}"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = "${var.ACRUserName}"
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = "${var.ACRPassword}"
    "sonar.jdbc.username"                 = "jdbc:sqlserver://${var.SQLServerFQDN};databaseName=${var.DBName}"
    "sonar.jdbc.password"                 = "${var.AdminUserName}"
    "sonar.jdbc.url"                      = "${var.AdminPassword}"
  }
}
