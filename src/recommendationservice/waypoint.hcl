project = "microservices-demo"

app "recommendationservice" {
  path = "."

  build {
    use "docker" {
      buildkit = true

    }
    registry {
      use "docker" {
        image = "tudfinalproject/recommendationservice"
        tag   = "latest"
      }
    }
  }

  config {
    env = {
      PRODUCT_CATALOG_SERVICE_ADDR = "productcatalogservice:80"
      DISABLE_DEBUGGER = "1"
      DISABLE_PROFILER = "1"
      DISABLE_TRACING = "1"
    }
  }

  deploy {
    use "kubernetes" {
      namespace = "waypoint-demo"

      probe_path = "/"
      pod {
        container {
          port {
            name = "http"
            port = 8080
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
        cpu_percent  = 20
      }
    }
  }
}