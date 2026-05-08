variable "openshift_server" {
  description = "OpenShift API URL"
  default     = "https://api.rm1.0a51.p1.openshiftapps.com:6443"
}

variable "openshift_token" {
  description = "OpenShift login token"
  sensitive   = true
}

variable "namespace" {
  description = "OpenShift Namespace"
  default     = "mounika-red-dev"
}

variable "app_name" {
  description = "Application Name"
  default     = "myfirstd"
}

variable "image" {
  description = "Docker Image"
  default     = "020217/my-app:v3"
}

variable "container_port" {
  description = "Application Container Port"
  default     = 5000
}

variable "replicas" {
  description = "Number of replicas"
  default     = 3
}
