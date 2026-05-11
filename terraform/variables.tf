variable "openshift_server" {

  description = "OpenShift API URL"
}

variable "openshift_token" {

  description = "OpenShift login token"
  sensitive   = true
}

variable "namespace" {

  default = "mounika-red-dev"
}

variable "app_name" {

  default = "myfirstd"
}

variable "image" {

  description = "Docker image"
}

variable "environment" {

  default = "dev"
}
variable "openshift_server" {

  description = "OpenShift API URL"
}

variable "openshift_token" {

  description = "OpenShift login token"
  sensitive   = true
}

variable "namespace" {

  default = "mounika-red-dev"
}

variable "app_name" {

  default = "funcapp"
}

variable "image" {
  description = "Docker image"
}

variable "environment" {

  default = "dev"
}
