locals {
  common_tags = {
    Owner       = "Sandeep Sharma"
    Description = "POC"
  }
}

resource "google_storage_bucket" "Input_Bucket" {
  name          = var.first_bucket
  storage_class = var.storage_class
  force_destroy = true
  location      = "US-CENTRAL1"
  labels = {
    "env"    = "env"
    "author" = "sandy"
  }
  uniform_bucket_level_access = true
}

output "first_bucket" {
  value = google_storage_bucket.Input_Bucket.url
}

resource "google_storage_bucket" "Output_Bucket" {
  name          = var.second_bucket
  storage_class = "STANDARD"
  location      = "US-CENTRAL1"
  force_destroy = true
  labels = {
    "env"    = "env"
    "author" = "sandy"
  }
  uniform_bucket_level_access = true
}

output "second_bucket" {
  value = google_storage_bucket.Output_Bucket.url
}
###############

# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke"
  location = var.zone
  #remove_default_node_pool = true
  initial_node_count = 2

  #network    = google_compute_network.vpc.name
  #subnetwork = google_compute_subnetwork.subnet.name
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  // These local-execs are used to provision the sample service
  // These local-execs are used to provision the sample service
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --zone ${google_container_cluster.primary.location} --project ${var.project}"
  }

  provisioner "local-exec" {
    command = "kubectl --namespace default create deployment brand-server --image gcr.io/poc-sandy-354205/brandimagedetect:1.0.0"
  }

  provisioner "local-exec" {
    command = "kubectl --namespace default expose deployment hello-server --type \"LoadBalancer\" --port=8080"
  }
}