terraform {
  required_version = "= 1.11.3"

  required_providers {
    aws = {
      version = "= 5.94.1"
    }
    null = {
      version = "= 3.2.3"
    }
    # Simply for the sake of verification
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "= 2.1.0"
    }
  }
}
