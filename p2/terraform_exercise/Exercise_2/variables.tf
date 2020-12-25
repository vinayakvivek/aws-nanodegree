# TODO: Define the variable for aws_region
variable "aws_region" {
  default = "us-east-1"
}

variable "lambda_name" {
  default = "greet_lambda"
}

variable "lambda_handler_name" {
  default = "lambda_handler"
}

variable "lambda_file" {
  default = "greet_lambda_payload.zip"
}

variable "lambda_runtime" {
  default = "python3.8"
}
