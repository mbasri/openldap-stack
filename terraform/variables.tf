variable "tags" {
  type        = map
  description = "Default tags to be applied on 'Xiaomi Mi Home Security Camera 360 Backup' infrastructure"
  default = {
    "Billing:Organisation"     = "Kibadex"
    "Billing:OrganisationUnit" = "Kibadex Labs"
    "Billing:Application"      = "CICD"
    "Billing:Environment"      = "Prod"
    "Billing:Contact"          = "mbasri@outlook.fr"
    "Technical:Terraform"      = "True"
    "Technical:Version"        = "1.0.0"
    #"Technical:Comment"        = "Managed by Terraform"
    #"Security:Compliance"      = "HIPAA"
    #"Security:DataSensitity"   = "1"
    "Security:Encryption" = "True"
  }
}

variable "name" {
  type        = map
  description = "Default tags name to be applied on the infrastructure for the resources names"
  default = {
    Application      = "cic"
    Environment      = "prd"
    Organisation     = "kbd"
    OrganisationUnit = "lab"
  }
}

# https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html
variable "backup_cron" {
  type        = string
  description = "Backup cron tu use for EBS backup"
  default     = "cron(26 * * * ? *)"

}

locals {
  secret_name           = "/cicd/ldap/${join("-", [var.name["Organisation"], var.name["OrganisationUnit"], var.name["Application"], var.name["Environment"], "pri"])}"
  backup_vault_name     = "${join("-", [var.name["Organisation"], var.name["OrganisationUnit"], var.name["Application"], var.name["Environment"], "pri"])}"
  backup_plan_name      = "${join("-", [var.name["Organisation"], var.name["OrganisationUnit"], var.name["Application"], var.name["Environment"], "pri"])}"
  backup_selection_name = "${join("-", [var.name["Organisation"], var.name["OrganisationUnit"], var.name["Application"], var.name["Environment"], "pri"])}"
  iam_role_backup_name  = "${join("-", [var.name["Organisation"], var.name["OrganisationUnit"], var.name["Application"], var.name["Environment"], "pri"])}"
}
