output "namespace" {
  description = "Kubernetes namespace where Scaphandre is deployed"
  value       = helm_release.scaphandre.namespace
}

output "release_name" {
  description = "Helm release name of Scaphandre"
  value       = helm_release.scaphandre.name
}

output "chart_version" {
  description = "Chart version of Scaphandre deployment"
  value       = helm_release.scaphandre.version
}
