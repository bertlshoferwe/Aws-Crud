# Output the nameservers for manual DNS configuration for domain registrar to point ot Route53
output "nameservers" {
  value = aws_route53_zone.primary.name_servers
}
# Output the URL of the Lambda function for easy access
output "lambda_function_url" {
  value = aws_lambda_function_url.example_function_url.function_url
}