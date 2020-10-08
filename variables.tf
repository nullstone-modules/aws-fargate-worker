variable "owner_id" {
  type = string
}

variable "stack_name" {
  type = string
}

variable "env" {
  type = string
}

variable "block_name" {
  type = string
}

variable "parent_blocks" {
  type = object({
    cluster  = string
    postgres = string
  })
}

variable "backend_conn_str" {
  type = string
}


variable "service_count" {
  type    = number
  default = 1
}

variable "service_cpu" {
  type    = number
  default = 256
}

variable "service_memory" {
  type    = number
  default = 512
}

variable "service_image_tag" {
  type    = string
  default = "latest"
}

variable "service_env_vars" {
  type    = map(string)
  default = {}
}
