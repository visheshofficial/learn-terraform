terraform {
  #   required_version = ">= 0.12"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }

  }
}

provider "github" {
  token = ""
}

resource "github_repository" "example"{
    name = "example"
    description = "My awesome codebase"
    visibility = "public"
}

output github_repository_url{
    value = github_repository.example.http_clone_url
}