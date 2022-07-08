variable "project_id" {
  description = "project id"
}

variable "project" {
  description = "project id"
}


variable "region" {
  description = "region"
  default     = "us-central1"
}

variable "zone" {
  description = "The zone in which to create the Kubernetes cluster. Must match the region"
  type        = string
  default     = "us-central1-a"
}

## GKE Settings from here ##
variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}

variable "first_bucket" {
  default = "poc-input-bucket-sandy"
  type    = string
}

variable "second_bucket" {
  default = "poc-output-bucket-sandy"
}

variable "storage_class" {

}

variable "environment" {
  default = "POC_ENV"
}

variable "author" {
  default = "Sandeep Sharma"
}