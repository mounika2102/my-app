variable "namespace" {
  description = "OpenShift namespace"
  type        = string
}

variable "app_name" {
  description = "Application name"
  type        = string
}

variable "image" {
  description = "Docker image"
  type        = string
  default     = "docker.io/nginx"
}

variable "openshift_server" {
  description = "OpenShift API Server"
  type        = string
}

variable "openshift_token" {
  description = "OpenShift Token"
  type        = string
  sensitive   = true
}
