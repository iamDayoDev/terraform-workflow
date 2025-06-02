resource "aws_s3_bucket" "terraform_state" {
  bucket = var.s3_bucket_name
}

# resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
#   bucket = aws_s3_bucket.terraform_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.tags
}
