output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "ARN del bucket S3"
}

output "bucket_name" {
  value       = aws_s3_bucket.this.id
  description = "Nombre del bucket S3"
}