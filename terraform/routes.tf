# list endpiont
resource "aws_api_gateway_method" "list" {
  rest_api_id   = "${aws_api_gateway_rest_api.main.id}"
  resource_id   = "${aws_api_gateway_resource.list.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "list" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  # change this from proxy to status
  resource_id = "${aws_api_gateway_resource.list.id}"
  http_method = "${aws_api_gateway_method.list.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${module.LambdaList.invoke_arn}"
  content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_resource" "list" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  parent_id   = "${aws_api_gateway_rest_api.main.root_resource_id}"
  path_part   = "list"
}

# status endpiont
resource "aws_api_gateway_method" "status" {
  rest_api_id   = "${aws_api_gateway_rest_api.main.id}"
  resource_id   = "${aws_api_gateway_resource.status.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "status" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  # change this from proxy to status
  resource_id = "${aws_api_gateway_resource.status.id}"
  http_method = "${aws_api_gateway_method.status.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${module.LambdaStatus.invoke_arn}"
  content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_resource" "status" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  parent_id   = "${aws_api_gateway_rest_api.main.root_resource_id}"
  # to proxy everything just use this
  # path_part   = "{proxy+}"
  path_part   = "status"
}

# the root
resource "aws_api_gateway_method" "root" {
  rest_api_id   = "${aws_api_gateway_rest_api.main.id}"
  resource_id   = "${aws_api_gateway_rest_api.main.root_resource_id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "root" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  resource_id = "${aws_api_gateway_method.root.resource_id}"
  http_method = "${aws_api_gateway_method.root.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${module.LambdaIndex.invoke_arn}"
  content_handling = "CONVERT_TO_TEXT"
}
