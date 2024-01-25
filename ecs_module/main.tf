# # ecs_module/main.tf
# module "ecs_setup" {
#   source = "./ecs_module"

#   region           = var.region
#   cluster_name     = var.cluster_name
#   task_family      = var.task_family
#   container_name   = var.container_name
#   image            = var.image
#   container_port   = var.container_port
#   host_port        = var.host_port
#   target_group_name = var.target_group_name
#   desired_count    = var.desired_count
#   subnets          = var.subnets
#   security_groups  = var.security_groups
#   container_cpu = var.container_cpu
#   container_memory = var.container_memory
# }
