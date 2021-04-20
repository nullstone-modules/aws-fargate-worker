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

resource "random_string" "resource_suffix" {
  length  = 5
  lower   = true
  upper   = false
  number  = false
  special = false
}
