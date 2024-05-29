
data "aws_availability_zones" "azs" {
  state = "available"
}

data "aws_vpc" "vpc" {
  default = true
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name   = "availabilityZone"
    values = [for i in range(3) : data.aws_availability_zones.azs.names[i]]
  }
}

module "eks" {
  source                                   = "terraform-aws-modules/eks/aws"
  cluster_name                             = var.cluster_name
  cluster_version                          = var.kubernetes_version
  subnet_ids                               = data.aws_subnets.subnets.ids
  vpc_id                                   = data.aws_vpc.vpc.id
  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true
  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = var.desired_capacity
      max_capacity     = var.max_capacity
      min_capacity     = var.min_capacity

      instance_type = var.node_instance_type
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}

resource "helm_release" "nginx" {
  name       = "nginx"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
  # values = [
  #   file("${path.module}/nginx-values.yaml")
  # ]
}