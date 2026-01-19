terraform {
  required_version = ">= 1.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

module "scaphandre" {
  source = "../"

  release_name    = "scaphandre"
  namespace       = "scaphandre-system"
  chart_version   = ""

  values = yamlencode({})
}
