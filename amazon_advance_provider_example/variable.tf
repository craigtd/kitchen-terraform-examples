variable "instances_ami" {
  description = "The AMI of the instances"
  type        = "string"
}

variable "key_pair_public_key" {
  description = "The public key of the key pair"
  type        = "string"
}

variable "provider_region" {
  description = "The geographic area in which the provider will place resources"
  type        = "string"
}

variable "subnet_availability_zone" {
  description = "The isolated, regional location in which to place the subnet"
  type        = "string"
}

