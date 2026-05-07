output "namespace" {
  value = var.namespace
}

output "application_name" {
  value = var.app_name
}

output "service_name" {
  value = kubernetes_service.app_service.metadata[0].name
}
