module "LambdaIndex" {
  source  = "./lambda"
  Namespace = "${var.Namespace}"
  Environment = "${var.Environment}"
  Version = "${var.Version}"
  GatewayExecutionArn = "${aws_api_gateway_deployment.main.execution_arn}/GET/"
  FunctionName = "index"
  FunctionHandler = "main.index"
  Runtime = "nodejs8.10"
}

module "LambdaStatus" {
  source  = "./lambda"
  Namespace = "${var.Namespace}"
  Environment = "${var.Environment}"
  Version = "${var.Version}"
  GatewayExecutionArn = "${aws_api_gateway_deployment.main.execution_arn}/GET/status"
  FunctionName = "status"
  FunctionHandler = "main.status"
  Runtime = "nodejs8.10"
}

module "LambdaList" {
  source  = "./lambda"
  Namespace = "${var.Namespace}"
  Environment = "${var.Environment}"
  Version = "${var.Version}"
  GatewayExecutionArn = "${aws_api_gateway_deployment.main.execution_arn}/GET/list"
  FunctionName = "list"
  FunctionHandler = "main.list"
  Runtime = "nodejs8.10"
}
