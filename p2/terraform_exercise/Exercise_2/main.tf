terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

locals {
  lambda_log_group = "/aws/lambda/${var.lambda_name}"
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "logs:CreateLogGroup",
        ],
        "Resource": "arn:aws:logs:*:*:*",
        "Effect": "Allow"
      },
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": [
          "arn:aws:logs:*:*:log-group:/aws/lambda/${var.lambda_name}:*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
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
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/${var.lambda_name}.py"
  output_path = "${path.module}/${var.lambda_file}"
}

resource "aws_lambda_function" "greet_lambda" {
  role             = aws_iam_role.iam_for_lambda.arn
  filename         = var.lambda_file
  function_name    = var.lambda_name
  handler          = "${var.lambda_name}.${var.lambda_handler_name}"
  source_code_hash = filebase64sha256(var.lambda_file)
  runtime          = var.lambda_runtime

  environment {
    variables = {
      greeting = "Hello there!"
    }
  }
}
