project = "microservices-demo"

app "adservice" {
  path = "."

  build {
    use "docker" {
      buildkit = true

    }
    registry {
      use "docker" {
        image = "tudfinalproject/adservice"
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
            port = 9555
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
        cpu_percent  = 90
      }
    }
  }
}
