# Exercise 4.1 — Log Archive and User Event Ledger

## Evidence

### terraform state list
```text
module.log_archive.aws_s3_bucket.this
module.log_archive.aws_s3_bucket_lifecycle_configuration.this
module.log_archive.aws_s3_bucket_policy.this
module.log_archive.aws_s3_bucket_server_side_encryption_configuration.this
module.log_archive.aws_s3_bucket_versioning.this
module.user_events.aws_dynamodb_table.this
```

### terraform output
```text
log_archive_bucket_arn = "arn:aws:s3:::logistics-log-archive-dev"
user_events_table_name = "user-events-dev"
```
