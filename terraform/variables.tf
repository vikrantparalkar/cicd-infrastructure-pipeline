variable "region" {
  default     = "us-east-1"
}

variable "cluster_name" {
  default     = "nginx-eks2"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "node_group_instance_types" {
  default     = ["t3.medium"]
}

variable "node_group_desired" {
  default = 2
}
