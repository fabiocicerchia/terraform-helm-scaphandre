output "namespace" {
  description = "The namespace where Scaphandre is deployed"
  value       = module.scaphandre.namespace
}

output "release_name" {
  description = "The Helm release name of Scaphandre"
  value       = module.scaphandre.release_name
}

output "version" {
  description = "The version of Scaphandre deployed"
  value       = module.scaphandre.version
}
