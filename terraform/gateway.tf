resource "aws_api_gateway_account" "main" {
  cloudwatch_role_arn = "${aws_iam_role.cloudwatch.arn}"
}

resource "aws_api_gateway_rest_api" "main" {
  name        = "${var.Namespace}${var.Environment}GetFnky"
  description = "Gateway of ${var.Namespace} in the ${var.Environment} environment"
}

# default deployment is needed to satisfy dependencies
resource "aws_api_gateway_deployment" "main" {
  depends_on = [
    "aws_api_gateway_integration.status",
    "aws_api_gateway_integration.root",
  ]

  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  stage_name  = "${var.Version}"
}

resource "aws_api_gateway_method_settings" "settings" {
  depends_on  = [
    "aws_api_gateway_account.main",
    "aws_api_gateway_deployment.main",
  ]
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  stage_name  = "${var.Version}"
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level = "INFO"
  }
}

resource "aws_api_gateway_domain_name" "main" {
  count = "${var.EnableCustomDomain}"
  depends_on = [
    "aws_acm_certificate_validation.cert"
  ]
  domain_name = "${var.Version}.${var.SubDomain}.${var.TopLevelDomain}"
  certificate_arn = "${aws_acm_certificate.cert.arn}"
}

resource "aws_api_gateway_base_path_mapping" "test" {
  api_id      = "${aws_api_gateway_rest_api.main.id}"
  stage_name  = "${aws_api_gateway_deployment.main.stage_name}"
  domain_name = "${aws_api_gateway_domain_name.main.domain_name}"
}

resource "aws_iam_role" "cloudwatch" {
  name = "${var.Namespace}${var.Environment}ApiGatewayCloudwatchAccessGlobalRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "cloudwatch" {
  name = "default"
  role = "${aws_iam_role.cloudwatch.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:GetLogEvents",
                "logs:FilterLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
