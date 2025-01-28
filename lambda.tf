module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"

  function_name = "lambda-view-counter"
  handler       = "index.lambda_handler"
  runtime       = "python3.8" # Specify the runtime you're using

  source_path = [
    {
      path = "${path.module}/lambda_function.py" # Path to your Python script
    }
  ]
}

# Lambda Function URL
resource "aws_lambda_function_url" "function_url" {
  function_name      = module.lambda_function.lambda_function_name
  authorization_type = "NONE" # If you want no authorization, use "NONE"
  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}

