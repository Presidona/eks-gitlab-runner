variable "region" {
  description = "AWS region"
  default     = "eu-central-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "EKS cluster version"
  default     = "1.25"
}

variable "subnet_ids" {
  description = "List of subnets"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "linux_desired_capacity" {
  description = "Desired capacity for Linux nodes"
  type        = number
  default     = 2
}

variable "linux_max_capacity" {
  description = "Maximum capacity for Linux nodes"
  type        = number
  default     = 5
}

variable "linux_min_capacity" {
  description = "Minimum capacity for Linux nodes"
  type        = number
  default     = 0
}

variable "linux_instance_type" {
  description = "Instance type for Linux nodes"
  type        = string
  default     = "t3.large"
}

variable "windows_desired_capacity" {
  description = "Desired capacity for Windows nodes"
  type        = number
  default     = 1
}

variable "windows_max_capacity" {
  description = "Maximum capacity for Windows nodes"
  type        = number
  default     = 1
}

variable "windows_min_capacity" {
  description = "Minimum capacity for Windows nodes"
  type        = number
  default     = 0
}

variable "windows_instance_type" {
  description = "Instance type for Windows nodes"
  type        = string
  default     = "t3.small"
}
