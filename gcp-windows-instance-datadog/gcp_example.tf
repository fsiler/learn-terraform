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
  name         = "terraform-windows-example-datadog"
  machine_type = "n1-standard-1"
  //  metadata_startup_script = "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); choco feature enable -n=allowGlobalConfirmation; choco install datadog"
  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-2019"
    }
  }
  network_interface {
    network = "default"
    access_config { // if you don't put this section, no network!  whoops.
      // Ephemeral IP
    }
  }
  metadata = {
    sysprep-specialize-script-ps1 = "New-Item c:\\frankwashere.txt; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); if($?) { New-Item c:\\frankwashere1.txt -type file };choco feature enable -n=allowGlobalConfirmation; if($?) { New-Item c:\\frankwashere2.txt -type file}; choco install datadog-agent; if($?) { New-Item c:\\frankwashere3.txt -type file}"
    //Start-Process -Wait msiexec -ArgumentList '/qn /i datadog-agent-7-latest.amd64.msi APIKEY=\"${var.DD_API_KEY}\" HOSTNAME=\"my_hostname\" TAGS=\"mytag1,mytag2\"'"
    //    sysprep-specialize-script-ps1 = "New-Item c:\\frankwashere.txt -type file"
  }

}
