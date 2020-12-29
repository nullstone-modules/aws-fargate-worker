# block-aws-fargate-worker

Nullstone Block standing up a worker as an AWS Fargate container service using ECR and configured to emit to AWS CloudWatch Logs.

## Inputs

- `service_count: number`
  - Default: `1`
- `service_cpu: number`
  - Service CPU Allocation
  - Measure in CPU shares as defined by docker
  - Default: `256`
- `service_memory: number`
  - Service Hard-Limit on Memory
  - Measured in MB 
  - Default: `512`

## Outputs

- `log_group_name`
  - Name of CloudWatch Log Group for service
- `repo_name`
  - Container Image Name for Service
- `service_name`
  - Name of AWS ECS Service
- `task_family`
  - Name of single AWS ECS Task 
