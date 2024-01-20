module "ecs_setup" {
  source = "./ecs_module"

  region            = var.region
  cluster_name      = "Staging"
  task_family       = "nginx"
  container_name    = "nginx"
  image             = "nginx:latest"
  container_port    = 80
  host_port         = 80
  container_cpu     = "256"
  container_memory  = "512"
  target_group_name = "nginx"
  desired_count     = 2
  subnets           = aws_subnet.public_subnets.*.id
  security_groups   = [aws_security_group.web_sg.id]
  vpc_id = aws_vpc.main.id
}