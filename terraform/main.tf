provider "aws" {
  region = var.region
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "18.30.0"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids

  eks_managed_node_groups = {
    linux = {
      name             = "linux-nodes"
      desired_capacity = var.linux_desired_capacity
      max_capacity     = var.linux_max_capacity
      min_capacity     = var.linux_min_capacity
      instance_type    = var.linux_instance_type
      key_name         = var.key_name
    },
    windows = {
      name             = "windows-nodes"
      desired_capacity = var.windows_desired_capacity
      max_capacity     = var.windows_max_capacity
      min_capacity     = var.windows_min_capacity
      instance_type    = var.windows_instance_type
      ami_type         = "WINDOWS_CORE_2022_BASE"
      key_name         = var.key_name
    }
  }
}

resource "kubernetes_namespace" "gitlab" {
  metadata {
    name = "gitlab"
  }
}
