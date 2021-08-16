
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      version = "~> 3.42.0"
    }
    null = {
      version = "~> 3.1.0"
    }
    # Simply for the sake of verification
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.42.0"
    }
  }
}
