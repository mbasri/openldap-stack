output "secret_name" {
  description = "Secret name"
  value       = aws_secretsmanager_secret.main.name
}
