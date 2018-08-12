resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "${var.namespace}-lambda-bucket"
  acl    = "private"

  tags {
    Name        = "${var.namespace}"
    Environment = "${var.Environment}"
  }
}
