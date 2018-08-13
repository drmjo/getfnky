resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "status" {
  filename         = "lambda/status/build/pkg.zip"
  function_name    = "${var.Namespace}${var.Environment}-status"
  role             = "${aws_iam_role.lambda_exec.arn}"
  handler          = "main.status"
  source_code_hash = "${base64sha256(file("lambda/status/build/pkg.zip"))}"
  runtime          = "nodejs8.10"
  # nodejs
  # nodejs4.3
  # nodejs6.10
  # nodejs8.10
  # java8
  # python2.7
  # python3.6
  # dotnetcore1.0
  # dotnetcore2.0
  # dotnetcore2.1
  # nodejs4.3-edge
  # go1.x

  environment {
    variables = {
      Name = "${var.Namespace}"
      Environment = "${var.Environment}"
    }
  }
}

resource "aws_lambda_permission" "status" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.status.arn}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_deployment.main.execution_arn}/*/*"
}
