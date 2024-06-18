provider "aws" {
    region = "${var.AWS_REGION}"
}

data "aws_s3_bucket" "existing_bucket" {
  bucket = var.s3_bucket_name
}

# Example output to verify the bucket's ARN
output "bucket_arn" {
  value = data.aws_s3_bucket.existing_bucket.arn
}