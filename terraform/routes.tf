module "RouteList" {
  source = "./route"
  LambdaInvokeArn = "${module.LambdaList.invoke_arn}"
  ApiId = "${aws_api_gateway_rest_api.main.id}"
  ParentId = "${aws_api_gateway_rest_api.main.root_resource_id}"
  Method = "GET"
  Path = "list"
}

module "RouteStatus" {
  source = "./route"
  LambdaInvokeArn = "${module.LambdaStatus.invoke_arn}"
  ApiId = "${aws_api_gateway_rest_api.main.id}"
  ParentId = "${aws_api_gateway_rest_api.main.root_resource_id}"
  Method = "GET"
  Path = "status"
}

# the root lambda integration must be done outside the module as
# its a unique one ...
# there is no "path_part" and resource ... the lambda integration
# is directly attached to the gateway root resource id
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
