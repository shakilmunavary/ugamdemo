output "address" {
  value = "${aws_elb.example.dns_name}"
  description = "URL of the Docker Application : "
}
