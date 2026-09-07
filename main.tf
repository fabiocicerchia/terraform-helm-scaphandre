resource "helm_release" "scaphandre" {
  name       = var.release_name
  repository = "${path.module}/.upstream/helm/"
  chart      = "scaphandre"
  version    = var.chart_version != "" ? var.chart_version : null

  dependency_update = true
  create_namespace  = true
  namespace         = var.namespace
  replace           = true

  values = [yamlencode(var.values)]
}

# kubectl patch servicemonitor
resource "null_resource" "scaphandre_patch_servicemonitor" {
  provisioner "local-exec" {
    command = <<EOT
      kubectl patch servicemonitor -n ${var.namespace} ${var.release_name} \
        -p '{"spec":{"fallbackScrapeProtocol":"PrometheusText0.0.4"}}'
    EOT
  }

  depends_on = [helm_release.scaphandre]
}
