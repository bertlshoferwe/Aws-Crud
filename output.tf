# Output the nameservers for manual DNS configuration for domain registrar to point ot Route53
output "nameservers" {
  value = aws_route53_zone.primary.name_servers
}