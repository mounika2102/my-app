variable "namespace" {
  description = "OpenShift namespace"
  type        = string
  default     = "demo"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "demo-app"
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
