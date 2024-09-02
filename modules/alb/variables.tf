variable "aws_region" {}
variable "aws_azs" {}
variable "common_tags" {}
variable "naming_prefix" {}
variable "vpc_id" {}
variable "public_subnets" {}
variable "instance_ids" {}

variable "domain_name" {
  description = "Domain Name"
  default     = "chinmayto.com"
}