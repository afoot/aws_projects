# Create IAM Role for lambda
resource "aws_iam_role" "lambda_role" {
 name   = "aws_lambda_role"
 assume_role_policy = jsondecode(
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
)
}

# Create IAM Policy for lambda
resource "aws_iam_policy" "iam_policy_for_lambda" {

  name         = "aws_iam_policy_for_aws_lambda_role"
  path         = "/"
  description  = "AWS IAM Policy for managing aws lambda role"
  policy = jsondecode(
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
)
}

# Attach IAM Policy to IAM Role
resource "aws_iam_role_policy_attachment" "attach_policy_to_role" {
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
  role       = aws_iam_role.lambda_role.name
}

# Create Lambda Function
resource "aws_lambda_function" "lambda_function" {
  function_name = "lambda_function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  filename      = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")
  timeout       = 10
  memory_size   = 128
  depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

# API Gateway integration with Lambda
resource "aws_lambda_permission" "apigw" {
 statement_id  = "AllowAPIGatewayInvoke"
 action        = "lambda:InvokeFunction"
 function_name = aws_lambda_function.lambda_function.function_name
 principal     = "apigateway.amazonaws.com"
 # The "/*/*" portion grants access from any method on any resource within the API Gateway REST API.
 source_arn = "${aws_api_gateway_rest_api.example.execution_arn}/*/*"
}

# Create API Gateway
resource "aws_api_gateway_rest_api" "example" {
 name        = "example_api"
 description = "Example API"
}

# Create API Gateway Resource
resource "aws_api_gateway_resource" "example" {
 rest_api_id = aws_api_gateway_rest_api.example.id
 parent_id   = aws_api_gateway_rest_api.example.root_resource_id
 path_part   = "{proxy+}"
}

# Create API Gateway Method
resource "aws_api_gateway_method" "example" {
 rest_api_id   = aws_api_gateway_rest_api.example.id
 resource_id   = aws_api_gateway_resource.example.id
 http_method   = "ANY"
authorization  = "NONE"
}

# Create API Gateway Integration
resource "aws_api_gateway_integration" "example" {
 rest_api_id = aws_api_gateway_rest_api.example.id
 resource_id = aws_api_gateway_resource.example.id
 http_method = aws_api_gateway_method.example.http_method
 type        = "AWS_PROXY"
 integration_http_method = "POST"
 uri         = aws_lambda_function.lambda_function.invoke_arn
}


