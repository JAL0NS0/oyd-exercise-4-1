output "log_archive_bucket_arn" {
  value       = module.log_archive.bucket_arn
  description = "ARN del bucket de S3 para logs"
}

output "user_events_table_name" {
  value       = module.user_events.table_name
  description = "Nombre de la tabla de DynamoDB para eventos"
}