project = "microservices-demo"

app "frontend" {
  path = "."


  build {
    use "docker" {
      buildkit = true

    }
    registry {
      use "docker" {
        image = "tudfinalproject/frontend"
        tag   = "latest"
      }
    }
  }

  config {
    env = {
      DISABLE_DEBUGGER = "1"
      DISABLE_PROFILER = "1"
      DISABLE_TRACING = "1"
      PRODUCT_CATALOG_SERVICE_ADDR = "productcatalogservice"
      CURRENCY_SERVICE_ADDR = "currencyservice"
      CART_SERVICE_ADDR = "cartservice"
      RECOMMENDATION_SERVICE_ADDR = "recommendationservice"
      SHIPPING_SERVICE_ADDR = "shippingservice"
      CHECKOUT_SERVICE_ADDR = "checkoutservice"
      AD_SERVICE_ADDR = "adservice"
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
    }
  }
}