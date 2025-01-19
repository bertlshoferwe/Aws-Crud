resource "aws_route53_zone" "primary" {
  name = "example.com" #update to your actual domain
}

resource "aws_route53_record" "example_com" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "example.com" #Update to match actual domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_example_com" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "www.example.com" #update to your actual domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}