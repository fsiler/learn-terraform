provider "google" {
  credentials = file("/Users/fms/gcp-creds.json")
  project     = "frank-251622"
  region      = "us-central1"
  zone        = "us-central1-c"
}

variable "DD_API_KEY" {
  type = string
}

resource "google_compute_instance" "terraform_example" {
  name                    = "terraform-example-hostname"
  machine_type            = "f1-micro"
  metadata_startup_script = "DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${var.DD_API_KEY} bash -c \"$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)\""
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"
    }
  }
  network_interface {
    network = "default"
    access_config { // if you don't put this section, no network!  whoops.
      // Ephemeral IP
    }
  }

}
