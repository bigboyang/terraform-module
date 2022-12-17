variable "alb_name" {
  description = "alb name"
  type        = string
}

variable "cluster_name" {
  description = "cluster name"
  type        = string
}

variable "target_group_arns" {
  description = "target_group_arns"
  type        = string
  default     = "default"
}