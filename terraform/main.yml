terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "demo" {
  metadata {
    name = "demo"
  }
}

resource "kubernetes_deployment" "app" {

  metadata {
    name = "demo-app"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }

  spec {

    replicas = 1

    selector {
      match_labels = {
        app = "demo-app"
      }
    }

    template {

      metadata {
        labels = {
          app = "demo-app"
        }
      }

      spec {

        container {

          image = "docker.io/YOUR_DOCKERHUB/demo-app:latest"
          name  = "demo-app"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}
