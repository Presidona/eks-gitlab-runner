provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = module.eks_infrastructure.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_infrastructure.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
