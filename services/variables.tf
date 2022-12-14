variable "cluster_name" {
  description = "cluster name"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "s3 name"
  type        = string
}

variable "db_remote_state_key" {
  description = "s3 key name"
  type        = string
}

variable "custom_tags" {
  description       = "ASG custom tags"
  type              = map(string)
  default           = {}
}

variable "enable_autoscaling" {
  description       = "If set to true, enable AutoSacling"
  type              = bool
  default           = false
}

variable  "instance_type" {
  description = "cluster name"
  type        = string
  default     = "t2"
}

variable "server_text" {
  description = "서버가 리턴해야하는 값"
  default     = "Hello world"
  type        = string
}

variable "min_size" {
  description = "asg min size"
  default     = 2
  type        = number
}

variable "max_size" {
  description = "asg max size"
  default     = 4
  type        = number
}

variable "environment" {
  description = "env"
  type        = string
  default     = "staging"
}

