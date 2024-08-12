terraform {
  required_version = "= 1.9.1"

  required_providers {
    aws = {
      version = "= 5.62.0"
    }
    null = {
      version = "= 3.2.2"
    }
    # Simply for the sake of verification
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "= 1.54.0"
    }
  }
}
