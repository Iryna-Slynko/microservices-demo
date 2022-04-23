project = "microservices-demo"

app "cartservice" {
  path = "."


  build {
    use "docker" {
      buildkit = true

    }
    registry {
      use "docker" {
        image = "tudfinalproject/cartservice"
        tag   = "latest"
      }
    }
  }

  config {
    env = {
      DISABLE_DEBUGGER = "1"
      DISABLE_PROFILER = "1"
      DISABLE_TRACING = "1"
    }
  }

  deploy {
    use "kubernetes" {
      namespace = "waypoint-demo"

      pod {
        container {
          port {
            name = "http"
            port = 7070
          }
        }
      }

      cpu {
        request = "100m"
        limit   = "200m"
      }

      autoscale {
        min_replicas = 1
        max_replicas = 5
        cpu_percent  = 90
      }
    }
  }
}