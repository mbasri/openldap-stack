resource "aws_iam_role" "backup" {
  name               = local.iam_role_backup_name
  description        = "[Terraform] IAM roles for AWS Backup"
  assume_role_policy = file("files/iam/backup-role.json")
  tags               = merge(var.tags, map("Name", local.secret_name))
}

resource "aws_iam_role_policy_attachment" "backup" {
  role       = aws_iam_role.backup.name
  policy_arn = data.aws_iam_policy.backup.arn
}

resource "aws_iam_role_policy_attachment" "restore" {
  role       = aws_iam_role.backup.name
  policy_arn = data.aws_iam_policy.restore.arn
}