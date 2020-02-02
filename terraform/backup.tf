# Backup LDAP files to S3
resource "aws_s3_bucket" "main" {
  bucket = local.backup_bucket_name
  region = data.terraform_remote_state.main.outputs.region
  acl    = "private"
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = data.aws_kms_alias.s3.arn
      }
    }
  }
  
  logging {
    target_bucket = data.terraform_remote_state.main.outputs.bucket_name_s3_accesslog_bucket
    target_prefix = "s3/${local.backup_bucket_name}/"
  }
  
  tags   = merge(var.tags, map("Name", local.backup_bucket_name))
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket                  = aws_s3_bucket.main.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# For EBS
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
