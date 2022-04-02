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
      PRODUCT_CATALOG_SERVICE_ADDR = "productcatalogservice:80"
      CURRENCY_SERVICE_ADDR = "currencyservice:80"
      CART_SERVICE_ADDR = "cartservice:80"
      RECOMMENDATION_SERVICE_ADDR = "recommendationservice:80"
      SHIPPING_SERVICE_ADDR = "shippingservice:80"
      CHECKOUT_SERVICE_ADDR = "checkoutservice:80"
      AD_SERVICE_ADDR = "adservice:80"
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

  release {
    use "kubernetes" {
      load_balancer = true
      namespace = "waypoint-demo"
    }
  }
}