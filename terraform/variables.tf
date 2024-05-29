variable "region" {
  description = "The AWS region to deploy the EKS cluster."
  type        = string
  default     = "us-west-2"
}

# variable "vpc_id" {
#   description = "The VPC ID where the EKS cluster will be deployed."
#   type        = string
# }

# variable "subnet_ids" {
#   description = "The subnet IDs where the EKS cluster nodes will be deployed."
#   type        = list(string)
# }

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "my-eks-cluster"
}

variable "kubernetes_version" {
  description = "The EKS(kubernetes) version cluster."
  type        = string
  default     = "1.29"
}

variable "node_instance_type" {
  description = "The instance type for the EKS cluster nodes."
  type        = string
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "The desired number of nodes in the EKS cluster."
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "The maximum number of nodes in the EKS cluster."
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "The minimum number of nodes in the EKS cluster."
  type        = number
  default     = 1
}
