terraform {
  backend "s3" {
    bucket         = "backend-test-workmate-s3-state1546"
    key            = "dev/development.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dev_backend_table"
    encrypt        = true
  }
}
