resource "random_string" "admin" {
  length = 32
  special = false
  
  lifecycle {
    #prevent_destroy = true
    ignore_changes = [length, special]
  }
}

resource "random_string" "readonly" {
  length = 32
  special = false
  
  lifecycle {
    #prevent_destroy = true
    ignore_changes = [length, special]
  }
}

resource "aws_secretsmanager_secret" "main" {
  name                    = local.secret_name
  recovery_window_in_days = 0
  description             = "[Terraform] Admin & ReadOnly password for CICD LDAP"
  tags                    = merge(var.tags, map("Name", local.secret_name))
}

resource "aws_secretsmanager_secret_version" "main" {
  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = jsonencode(
  merge(
      map("ldap_admin_password", random_string.admin.result),
      map("ldap_readonly_password", random_string.readonly.result)
    )
  )
}

