#terraform main file
terraform {

  required_providers {

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
   host                   = var.openshift_server
   token                  = var.openshift_token
   insecure               = true
}

resource "kubernetes_deployment" "app" {

  metadata {
    name      = var.app_name
    namespace = var.namespace

    labels = {
      app = var.app_name
    }
  }

  spec {

    replicas = 1

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {

      metadata {

        labels = {
          app = var.app_name
        }
      }

      spec {

        container {

          image = var.image
          name  = var.app_name

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app_service" {

  metadata {
    name      = "${var.app_name}-service"
    namespace = var.namespace
  }

  spec {

    selector = {
      app = var.app_name
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
resource "null_resource" "route" {

  provisioner "local-exec" {

    command = <<EOT
oc login ${var.openshift_server} \
--token=${var.openshift_token} \
--insecure-skip-tls-verify

cat <<EOF | oc apply -f -
apiVersion: route.openshift.io/v1
kind: Route
metadata:
  name: ${var.app_name}-route
  namespace: ${var.namespace}
spec:
  to:
    kind: Service
    name: ${var.app_name}-service
  port:
    targetPort: 80
  tls:
    termination: edge
EOF

EOT
  }
}
