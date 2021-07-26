
provider "aws" {
 access_key = "${var.accesskey}"
 secret_key = "${var.seckey}"
 region = "${var.region}"
 version  = "~> 2.63"
}

