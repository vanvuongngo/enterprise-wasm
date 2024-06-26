terraform {
  required_version = "~>1.6.6"
  required_providers {
    azurerm = {
      source  = "registry.terraform.io/hashicorp/azurerm"
      version = "~>3.98"
    }
    azapi = {
      source  = "registry.terraform.io/Azure/azapi"
      version = "~>1.12"
    }
    kubernetes = {
      source  = "registry.terraform.io/hashicorp/kubernetes"
      version = "~>2.27"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~>1.14"
    }
    helm = {
      source  = "registry.terraform.io/hashicorp/helm"
      version = "~>2.13"
    }
    random = {
      source  = "registry.terraform.io/hashicorp/random"
      version = "~>3.6"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      # only keep this setting while evaluating - remove for production
      prevent_deletion_if_contains_resources = false
    }
    application_insights {
      disable_generated_rule = true
    }
    key_vault {
      # only keep this setting while evaluating - remove for production
      purge_soft_delete_on_destroy = true
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = module.aks.KUBE_ADMIN_CONFIG.0.host
    client_certificate     = base64decode(module.aks.KUBE_ADMIN_CONFIG.0.client_certificate)
    client_key             = base64decode(module.aks.KUBE_ADMIN_CONFIG.0.client_key)
    cluster_ca_certificate = base64decode(module.aks.KUBE_ADMIN_CONFIG.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = module.aks.KUBE_ADMIN_CONFIG.0.host
  client_certificate     = base64decode(module.aks.KUBE_ADMIN_CONFIG.0.client_certificate)
  client_key             = base64decode(module.aks.KUBE_ADMIN_CONFIG.0.client_key)
  cluster_ca_certificate = base64decode(module.aks.KUBE_ADMIN_CONFIG.0.cluster_ca_certificate)
}
