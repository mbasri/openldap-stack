resource "aws_backup_vault" main {
  name        = local.backup_vault_name
  kms_key_arn = data.aws_kms_alias.backup.target_key_arn
  tags        = merge(var.tags, map("Name", local.backup_vault_name))
  #kms_key_arn = "${aws_kms_key.example.arn}"
}

resource "aws_backup_plan" "main" {
  name = local.backup_plan_name

  rule {
    rule_name         = local.backup_plan_name
    target_vault_name = aws_backup_vault.main.name
    schedule          = var.backup_cron
    lifecycle {
      #cold_storage_after = 30
      delete_after = 15
    }
    recovery_point_tags = merge(var.tags, map("Name", local.backup_vault_name))
  }

  tags = merge(var.tags, map("Name", local.backup_vault_name))
}

resource "aws_backup_selection" "main" {
  iam_role_arn = aws_iam_role.backup.arn
  name         = local.backup_selection_name
  plan_id      = aws_backup_plan.main.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "kubernetes.io/created-for/pvc/name"
    value = "openldap-openldap-0"
  }

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "kubernetes.io/created-for/pvc/namespace"
    value = "default"
  }
}
