# list endpiont
resource "aws_api_gateway_method" "main" {
  rest_api_id   = "${var.ApiId}"
  resource_id   = "${aws_api_gateway_resource.main.id}"
  http_method   = "${upper(var.Method)}"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "main" {
  rest_api_id = "${var.ApiId}"
  # change this from proxy to status
  resource_id = "${aws_api_gateway_resource.main.id}"
  http_method = "${aws_api_gateway_method.main.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${var.LambdaInvokeArn}"
  content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_resource" "main" {
  rest_api_id = "${var.ApiId}"
  parent_id   = "${var.ParentId}"
  path_part   = "${var.Path}"
}
