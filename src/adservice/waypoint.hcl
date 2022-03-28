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
        tag = "latest"
      }
    }
  }

  deploy {
    use "kubernetes" {
      namespace = "waypoint-demo"
    }
  }
}