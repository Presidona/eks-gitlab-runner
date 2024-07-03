variable "cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
}

variable "cluster_certificate_authority_data" {
  description = "EKS cluster certificate authority data"
  type        = string
}

variable "cluster_id" {
  description = "EKS cluster ID"
  type        = string
}

variable "gitlab_registration_token" {
  description = "GitLab Runner registration token"
  type        = string
}
