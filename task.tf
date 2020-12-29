locals {
  env_vars = [for k, v in var.service_env_vars : map("name", k, "value", v)]

  container_definition = {
    name  = data.ns_workspace.this.block
    image = "${aws_ecr_repository.this.repository_url}:${var.service_image_tag}"
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
        "awslogs-region"        = data.aws_region.this.name
        "awslogs-group"         = aws_cloudwatch_log_group.this.name
        "awslogs-stream-prefix" = data.ns_workspace.this.env
      }
    }
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = data.ns_workspace.this.hyphenated_name
  cpu                      = var.service_cpu
  memory                   = var.service_memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = data.aws_iam_role.execution.arn
  container_definitions    = jsonencode([local.container_definition])

  tags = data.ns_workspace.this.tags
}
