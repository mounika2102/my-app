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

  default = "mysecond"
}

variable "image" {

  default = "020217/my-app:v3"
}

variable "environment" {

  default = "prod"
}
