terraform {
  backend "s3" {
    bucket         = "aws-cfn-scripts-and-source-code"
    key            = "terraform/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    # dynamodb_table = "your-dynamodb-lock-table" # Optional for state locking
  }
}
