resource "aws_ecs_service" "this" {
  name            = data.ns_workspace.this.block_name
  cluster         = data.aws_ecs_cluster.cluster.arn
  desired_count   = var.service_count
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  tags            = data.ns_workspace.this.tags

  network_configuration {
    subnets          = data.ns_connection.network.outputs.private_subnet_ids
    assign_public_ip = false
    security_groups  = compact([aws_security_group.this.id, local.db_user_security_group_id])
  }
}
