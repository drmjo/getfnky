# get the zone id of the top level domain in r53
data "aws_route53_zone" "tld" {
  name = "${var.TopLevelDomain}."
  private_zone = false
}

# Route53 is not specifically required; any DNS host can be used.
resource "aws_route53_record" "main" {
  zone_id = "${data.aws_route53_zone.tld.id}" # See aws_route53_zone for how to create this

  name = "${aws_api_gateway_domain_name.main.domain_name}"
  type = "A"

  alias {
    name                   = "${aws_api_gateway_domain_name.main.cloudfront_domain_name}"
    zone_id                = "${aws_api_gateway_domain_name.main.cloudfront_zone_id}"
    evaluate_target_health = false
  }
}
