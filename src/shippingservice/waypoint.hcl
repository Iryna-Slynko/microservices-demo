project = "microservices-demo"

app "shippingservice" {
  path = "."

  build {
    use "docker" {
      buildkit = true

    }
    registry {
      use "docker" {
        image = "tudfinalproject/shippingservice"
        tag   = "latest"
      }
    }
  }

  deploy {
    use "kubernetes" {
      namespace = "waypoint-demo"

      pod {
        container {
          port {
            name = "http"
            port = 50051
          }
        }
      }

      cpu {
        request = "250m"
        limit   = "500m"
      }

      autoscale {
        min_replicas = 1
        max_replicas = 5
        cpu_percent  = 20
      }
    }
  }
}