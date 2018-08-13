# this create a certificate for the custom domain if enabled
# and waits untill the certificate is valid ...
# if there is any resource that needs to use this certificate it MUST
# depend on "aws_acm_certificate_validation.cert" as without that resource
# there is no guarantee that the certificate is created and ACTIVE

# create an edge certificate in the us-east-1 region
resource "aws_acm_certificate" "cert" {
  count = "${var.EnableCustomDomain}"
  provider = "aws.edge"

  domain_name = "${var.Version}.${var.SubDomain}.${var.TopLevelDomain}"
  validation_method = "DNS"
}

# add the validation records to the ZONE
resource "aws_route53_record" "cert_validation" {
  count = "${var.EnableCustomDomain}"
  name = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
  type = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.tld.id}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
  ttl = 60
}

# return success when the domain certificate is validated
resource "aws_acm_certificate_validation" "cert" {
  count = "${var.EnableCustomDomain}"
  provider = "aws.edge"
  certificate_arn = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = [
    "${aws_route53_record.cert_validation.fqdn}"
  ]
}
