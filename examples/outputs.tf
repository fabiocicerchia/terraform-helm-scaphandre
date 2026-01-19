output "scaphandre_namespace" {
  description = "The namespace where Scaphandre is deployed"
  value       = module.scaphandre.namespace
}

output "scaphandre_release_name" {
  description = "The Helm release name of Scaphandre"
  value       = module.scaphandre.release_name
}

output "scaphandre_chart_version" {
  description = "The chart version of the deployed Scaphandre"
  value       = module.scaphandre.chart_version
}
