resource "aws_dynamodb_table" "prod" {
  name           = "terraform-state"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    "Name"      = "DynamoDB terraform lock state"
    Environment = var.env
  }
}


