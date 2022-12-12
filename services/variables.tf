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
}

variable  "instance_type" {
  description = "cluster name"
  type        = string
  default     = "t2"
}

variable  "eanble_new_user_data" {
  description     = "템플릿 지정 (1,2)"
  type            = bool
  default         = false
}