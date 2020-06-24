provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

variable "DD_API_KEY" {
  type = string
}

resource "aws_instance" "example" {
  ami           = "ami-000a7f413e7de3863"
  instance_type = "t2.micro"
  provisioner "remote-exec" {
    inline = [
      "DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${var.DD_API_KEY} bash -c \"$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)\""
    ]
  }
}
