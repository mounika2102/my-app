terraform {

  required_providers {

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }

    null = {
      source = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "kubernetes" {

  host     = var.openshift_server
  token    = var.openshift_token
  insecure = true
}

#################################################
# LOCALS
#################################################

locals {

  service_name = format(
    "%s-service",
    var.app_name
  )

  route_name = format(
    "%s-route",
    var.app_name
  )

  common_labels = {

    app  = var.app_name
    env  = var.environment
    team = "devops"
  }

  deployed_time = timestamp()

  replicas = var.environment == "prod" ? 3 : 1
}

#################################################
# DEPLOYMENT
#################################################

resource "kubernetes_deployment" "app" {

  metadata {

    name      = var.app_name
    namespace = var.namespace

    labels = local.common_labels

    annotations = {
      deployed_at = local.deployed_time
    }
  }

  spec {

    replicas = local.replicas

    selector {

      match_labels = {
        app = var.app_name
      }
    }

    template {

      metadata {

        labels = local.common_labels
      }

      spec {

        container {

          image = var.image
          name  = var.app_name

          port {
            container_port = 5000
          }

          env {

            name  = "ENV"
            value = var.environment
          }

          resources {

            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }

            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
          }
        }
      }
    }
  }
}

#################################################
# SERVICE
#################################################

resource "kubernetes_service" "app_service" {

  metadata {

    name      = local.service_name
    namespace = var.namespace

    labels = local.common_labels
  }

  spec {

    selector = {
      app = var.app_name
    }

    port {

      name        = "http"
      port        = 80
      target_port = 5000
    }

    type = "ClusterIP"
  }
}

#################################################
# ROUTE
#################################################

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
  name: ${local.route_name}
  namespace: ${var.namespace}
spec:
  to:
    kind: Service
    name: ${local.service_name}
  port:
    targetPort: http
  tls:
    termination: edge
EOF

EOT
  }
}