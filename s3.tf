module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "web-storage"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

}

# Bucket policy to allow CloudFront access
resource "aws_s3_bucket_policy" "allow_access_from_cloudfront" {
  bucket = module.s3_bucket.s3_bucket_id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal"
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${module.s3_bucket.s3_bucket_arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
          }
        }
      }
    ]
  })
}
