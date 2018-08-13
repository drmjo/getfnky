# resource "aws_s3_bucket" "lambda_bucket" {
#   bucket = "${var.Namespace}-lambda-bucket"
#   acl    = "private"
#
#   tags {
#     Name        = "${var.Namespace}"
#     Environment = "${var.Environment}"
#   }
# }
