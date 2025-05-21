module "backend_infra" {
  source      = "../../modules/backend"
  s3_bucket_name     = "backend-test-workmate-s3-state1546"
  dynamodb_table_name = "dev_backend_table"
  tags = {
    Environment = "dev"
  }
}
