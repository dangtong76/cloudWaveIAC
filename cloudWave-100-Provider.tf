provider "aws" {
  region = var.region
  profile = var.terraform-aws-profile
}

# Kubernetes 접속 정보 설정
data "aws_eks_cluster" "cwave-cluster" {
  name = module.cwave-eks.cluster_id
}

data "aws_eks_cluster_auth" "cwave-eks-auth" {
  name = module.cwave-eks.cluster_id
}

provider "kubernetes" {
  alias = "cwave-eks"
  host                   = data.aws_eks_cluster.cwave-cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cwave-eks-auth.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cwave-cluster.certificate_authority.0.data)
  # exec {
  #   api_version = "client.authentication.k8s.io/v1alpha1"
  #   args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cwave-cluster.name]
  #   command     = "aws"
  # }
  # load_config_file       = false
}

provider "helm" {
  alias = "cwave-eks-helm"
  kubernetes {
    host                   = data.aws_eks_cluster.cwave-cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cwave-eks-auth.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cwave-cluster.certificate_authority.0.data)
    # exec {
    # api_version = "client.authentication.k8s.io/v1alpha1"
    # args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cwave-cluster.name]
    # command     = "aws"
    # }
    # load_config_file       = false
  }
}





# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }

# # Configure the AWS Provider
# provider "aws" {
#   region = var.region
#   profile = var.terraform-aws-profile
# }