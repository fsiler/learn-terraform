provider "google" {
  project = "frank-251622"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "terraform_example" {
  name         = "terraform-example-hostname"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"
    }
  }
  network_interface {
    network = "default"
  }

}
