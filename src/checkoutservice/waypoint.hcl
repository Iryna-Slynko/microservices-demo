project = "microservices-demo"

app "paymentservice" {
  path = "."


  build {
    use "docker" {
      buildkit = true

    }
    registry {
      use "docker" {
        image = "tudfinalproject/paymentservice"
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
      SHIPPING_SERVICE_ADDR = "shippingservice"
      PAYMENT_SERVICE_ADDR = "paymentservice"
      EMAIL_SERVICE_ADDR = "emailservice"
      CURRENCY_SERVICE_ADDR = "currencyservice"
      CART_SERVICE_ADDR = "cartservice"
    }
  }

  deploy {
    use "kubernetes" {
      namespace = "waypoint-demo"

      pod {
        container {
          port {
            name = "http"
            port = 5050
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