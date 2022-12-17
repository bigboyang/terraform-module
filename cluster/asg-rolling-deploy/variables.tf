variable "subnet_ids" {
  description = "subnet_ids"
  type        = list(string)
}

variable "target_group_arns" {
  description = "target_group_arns"
  type        = string
}

variable "user_data" {
  description = "user_data"
  type        = string
  default     = null
}

variable "cluster_name" {
  description = "cluster name"
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