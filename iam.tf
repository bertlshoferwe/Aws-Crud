# IAM Role for DynamoDB to access Lambda
resource "aws_iam_role" "dynamodb_lambda_role" {
  name = "DynamoDBLambdaAccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "dynamodb.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for DynamoDB to invoke Lambda
resource "aws_iam_policy" "lambda_invoke_policy" {
  name        = "DynamoDBInvokeLambdaPolicy"
  description = "Allows DynamoDB to invoke Lambda functions"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ],
        Effect   = "Allow",
        Resource = "*" # Be more specific if you want to restrict to certain Lambda functions
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "dynamodb_lambda_attach" {
  role       = aws_iam_role.dynamodb_lambda_role.name
  policy_arn = aws_iam_policy.lambda_invoke_policy.arn
}