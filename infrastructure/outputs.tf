output "All-FQDNs" {
    value = "${aws_route53_record.user_instance.*.fqdn}"
}