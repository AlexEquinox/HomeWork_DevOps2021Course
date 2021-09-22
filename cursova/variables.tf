variable "region" {
default = "us-east-2"
}
variable "instance_type" {
default = "t2.micro"
}
variable "creds" {
default = "~/.aws/credentials"
}
variable "instance_key" {
default = "test_key_pair"
}
variable "vpc_cidr" {
default = "178.0.0.0/16"
}
variable "public_subnet_cidr" {
default = "178.0.10.0/24"
}