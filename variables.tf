variable "region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "us-east-2" # Replace with your default region
}

# variable "subnets" {
#   description = "List of subnets for the ECS service"
#   type        = list(string)
#   default = aws_subnet.public_subnets[*].id
# }

# variable "vpc_id" {
#   default = aws_vpc.main.id
# }

# variable "security_groups" {
#   description = "List of security group IDs for the ECS service"
#   type        = list(string)
#   default = [aws_security_group.web_sg.id]
# }