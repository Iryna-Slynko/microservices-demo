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

  deploy {
    use "kubernetes" {
      namespace = "waypoint-demo"

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

      static_environment {
        PRODUCT_CATALOG_SERVICE_ADDR = "productcatalogservice"
      }
    }
  }
}