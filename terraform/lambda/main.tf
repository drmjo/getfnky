resource "aws_iam_role" "lambda_exec" {
  name = "${var.Namespace}${var.Environment}LambdaExecusion${title(var.FunctionName)}"
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

resource "aws_lambda_function" "main" {
  filename         = "lambda/${var.FunctionName}/build/pkg.zip"
  function_name    = "${var.Namespace}${var.Environment}-${var.FunctionName}"
  role             = "${aws_iam_role.lambda_exec.arn}"
  handler          = "${var.FunctionHandler}"
  source_code_hash = "${base64sha256(file("lambda/${var.FunctionName}/build/pkg.zip"))}"
  runtime          = "${var.Runtime}"
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

resource "aws_lambda_permission" "main" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.main.arn}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  # if specified
  source_arn = "${var.GatewayExecutionArn}"
}
