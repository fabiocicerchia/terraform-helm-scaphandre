provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

resource "helm_release" "scaphandre" {
  name             = var.release_name
  namespace        = var.namespace
  create_namespace = true
  version          = var.chart_version != "" ? var.chart_version : null

  chart = "https://github.com/hubblo-org/scaphandre"

  values = [
    yamlencode(var.values)
  ]
}
