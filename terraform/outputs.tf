output "Namespace" {
  value = "${var.Namespace}"
}

output "Url" {
  value = "${aws_api_gateway_deployment.main.invoke_url}"
}
