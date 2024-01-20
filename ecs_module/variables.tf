variable "region" {
  description = "AWS region"
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
}

variable "task_family" {
  description = "Family name of the ECS task"
}

variable "container_name" {
  description = "Name of the container"
}

variable "image" {
  description = "Docker image for the container"
}

variable "container_port" {
  description = "Container port"
}

variable "host_port" {
  description = "Host port"
}

variable "target_group_name" {
  description = "Name of the target group"
}

variable "desired_count" {
  description = "Desired number of tasks to run"
}

variable "subnets" {
  description = "List of subnets for the ECS service"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs for the ECS service"
  type        = list(string)
}

variable "container_cpu" {
  description = "CPU needed for the container"
  default = "256"
}

variable "container_memory" {
  description = "Memory needed for the container"
  default = "512"
}

variable "vpc_id" {
  description = "VPC ID"
}