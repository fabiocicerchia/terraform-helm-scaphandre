variable "release_name" {
  description = "Helm release name for Scaphandre"
  type        = string
  default     = "scaphandre"
}

variable "namespace" {
  description = "Kubernetes namespace for Scaphandre"
  type        = string
  default     = "scaphandre"
}

variable "chart_version" {
  description = "Scaphandre Helm chart version (empty string for latest)"
  type        = string
  default     = ""
}

variable "values" {
  description = "Helm values for Scaphandre deployment"
  type        = any
  default     = {}
}
