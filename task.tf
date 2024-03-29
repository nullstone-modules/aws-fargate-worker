locals {
  env_vars = [for k, v in var.service_env_vars : map("name", k, "value", v)]

  container_definition = {
    name  = data.ns_workspace.this.block_name
    image = "${local.service_image}:${local.app_version}"
    portMappings = [
      {
        protocol      = "tcp"
        containerPort = 80
        hostPort      = 80
      }
    ]

    essential   = true
    environment = local.env_vars

    cpu               = var.service_cpu
    memoryReservation = var.service_memory

    mountPoints = []
    volumesFrom = []

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-region"       = data.aws_region.this.name
        "awslogs-group"        = module.logs.name
        "awslogs-stream-prefix" = data.ns_workspace.this.env_name
      }
    }
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = local.resource_name
  cpu                      = var.service_cpu
  memory                   = var.service_memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = data.aws_iam_role.execution.arn
  container_definitions    = jsonencode([local.container_definition])
  tags                     = data.ns_workspace.this.tags
}
