resource "aws_s3_bucket" "b" {
  bucket = "roc-tf-test-bucket"
  acl = "private"
  force_destroy = "true"

  versioning {
    enabled = true
  }
  object_lock_configuration {
      object_lock_enabled = "Enabled"
  }
  lifecycle {
        prevent_destroy = false
     }

  logging {
        target_bucket = aws_s3_bucket.log_bucket.id
        target_prefix = "log/"
      }
}

##########  log bucket resource #################

     resource "aws_s3_bucket" "log_bucket" {
       bucket = "my-tf-log-bucket"
       acl    = "log-delivery-write"
     }