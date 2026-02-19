provider "aws" {
  region = "us-east-1"
}

# --- 1. Networking ---
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
}

data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# --- 2. ECR Repository (Ye sabse zaroori hai) ---
resource "aws_ecr_repository" "strapi" {
  name         = "strapi-app"
  force_delete = true
}

output "ecr_url" {
  value = aws_ecr_repository.strapi.repository_url
}