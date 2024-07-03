module "eks_infrastructure" {
  source = "./modules/eks-infrastructure"

  region                 = var.region
  cluster_name           = var.cluster_name
  cluster_version        = var.cluster_version
  vpc_id                 = var.vpc_id
  subnet_ids             = var.subnet_ids
  key_name               = var.key_name
  linux_desired_capacity = var.linux_desired_capacity
  linux_max_capacity     = var.linux_max_capacity
  linux_min_capacity     = var.linux_min_capacity
  linux_instance_type    = var.linux_instance_type
  windows_desired_capacity = var.windows_desired_capacity
  windows_max_capacity     = var.windows_max_capacity
  windows_min_capacity     = var.windows_min_capacity
  windows_instance_type    = var.windows_instance_type
}

module "gitlab_runners" {
  source = "./modules/gitlab-runners"

  cluster_endpoint                   = module.eks_infrastructure.cluster_endpoint
  cluster_certificate_authority_data = module.eks_infrastructure.cluster_certificate_authority_data
  cluster_id                         = module.eks_infrastructure.cluster_id
  gitlab_registration_token          = var.gitlab_registration_token
}
