provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_id
}

resource "kubernetes_namespace" "gitlab" {
  metadata {
    name = "gitlab"
  }
}

resource "kubernetes_secret" "gitlab_runner_secret" {
  metadata {
    name      = "gitlab-runner-secret"
    namespace = kubernetes_namespace.gitlab.metadata[0].name
  }
  data = {
    registration_token = base64encode(var.gitlab_registration_token)
  }
}

resource "kubernetes_deployment" "gitlab_runner_linux" {
  metadata {
    name      = "gitlab-runner-linux"
    namespace = kubernetes_namespace.gitlab.metadata[0].name
  }
  spec {
    replicas = 5  # Adjusted initial number of replicas
    selector {
      match_labels = {
        app = "gitlab-runner-linux"
      }
    }
    template {
      metadata {
        labels = {
          app = "gitlab-runner-linux"
        }
      }
      spec {
        container {
          name  = "gitlab-runner-linux"
          image = "gitlab/gitlab-runner:latest"
          env {
            name  = "CI_SERVER_URL"
            value = "https://gitlab.example.com/"
          }
          env {
            name = "REGISTRATION_TOKEN"
            value_from {
              secret_key_ref {
                name = "gitlab-runner-secret"
                key  = "registration_token"
              }
            }
          }
          resources {
            limits = {
              cpu    = "4"
              memory = "8Gi"
            }
            requests = {
              cpu    = "2"
              memory = "4Gi"
            }
          }
          volume_mount {
            name      = "config"
            mount_path = "/etc/gitlab-runner"
          }
        }
        node_selector = {
          "kubernetes.io/os" = "linux"
        }
        volume {
          name = "config"
          empty_dir {}
        }
      }
    }
  }
}

resource "kubernetes_deployment" "gitlab_runner_windows" {
  metadata {
    name      = "gitlab-runner-windows"
    namespace = kubernetes_namespace.gitlab.metadata[0].name
  }
  spec {
    replicas = 1  # Adjusted initial number of replicas
    selector {
      match_labels = {
        app = "gitlab-runner-windows"
      }
    }
    template {
      metadata {
        labels = {
          app = "gitlab-runner-windows"
        }
      }
      spec {
        container {
          name  = "gitlab-runner-windows"
          image = "gitlab/gitlab-runner:latest"
          env {
            name  = "CI_SERVER_URL"
            value = "https://gitlab.example.com/"
          }
          env {
            name = "REGISTRATION_TOKEN"
            value_from {
              secret_key_ref {
                name = "gitlab-runner-secret"
                key  = "registration_token"
              }
            }
          }
          resources {
            limits = {
              cpu    = "2"
              memory = "4Gi"
            }
            requests = {
              cpu    = "1"
              memory = "2Gi"
            }
          }
          volume_mount {
            name      = "config"
            mount_path = "C:\\etc\\gitlab-runner"
          }
        }
        node_selector = {
          "kubernetes.io/os" = "windows"
        }
        volume {
          name = "config"
          empty_dir {}
        }
      }
    }
  }
}

resource "kubernetes_service" "gitlab_runner_service" {
  metadata {
    name      = "gitlab-runner"
    namespace = kubernetes_namespace.gitlab.metadata[0].name
  }
  spec {
    selector = {
      app = "gitlab-runner"
    }
    port {
      protocol = "TCP"
      port     = 80
      target_port = 8080
    }
  }
}

resource "kubernetes_horizontal_pod_autoscaler" "gitlab_runner_hpa_linux" {
  metadata {
    name      = "gitlab-runner-hpa-linux"
    namespace = kubernetes_namespace.gitlab.metadata[0].name
  }
  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "gitlab-runner-linux"
    }
    min_replicas = 5
    max_replicas = 20
    metric {
      type = "Resource"
      resource {
        name  = "cpu"
        target {
          type               = "Utilization"
          average_utilization = 70
        }
      }
    }
    metric {
      type = "Resource"
      resource {
        name  = "memory"
        target {
          type               = "Utilization"
          average_utilization = 70
        }
      }
    }
  }
}

resource "kubernetes_horizontal_pod_autoscaler" "gitlab_runner_hpa_windows" {
  metadata {
    name      = "gitlab-runner-hpa-windows"
    namespace = kubernetes_namespace.gitlab.metadata[0].name
  }
  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "gitlab-runner-windows"
    }
    min_replicas = 1
    max_replicas = 5
    metric {
      type = "Resource"
      resource {
        name  = "cpu"
        target {
          type               = "Utilization"
          average_utilization = 70
        }
      }
    }
    metric {
      type = "Resource"
      resource {
        name  = "memory"
        target {
          type               = "Utilization"
          average_utilization = 70
        }
      }
    }
  }
}
