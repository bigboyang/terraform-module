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