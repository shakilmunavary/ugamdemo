

resource "aws_launch_configuration" "demo" {
  image_id               = "${var.ami_id}"
  instance_type          = "t2.micro"
  security_groups        = ["${var.security_group_id}"]
  key_name               = "${var.keyname}"
  user_data = <<-EOF
              #!/bin/bash
	      echo "cloud init working" >> /home/ec2-user/test.txt
              yum -y install docker
	      systemctl enable docker.service
	      systemctl start docker
	      cd /home/ec2-user/
              curl -O -L https://raw.githubusercontent.com/shakilmunavary/SampleWebApp/master/dist/dockerfile
              cd /home/ec2-user/
	      docker build -t shakiltomcat .
	      docker container run -it -d --name demo -p 8080:8080 shakiltomcat:latest
	      echo "Done" >> /home/ec2-user/done.txt
              EOF
 }

resource "aws_autoscaling_group" "example" {
  launch_configuration = "${aws_launch_configuration.demo.id}"
  availability_zones = ["ap-south-1a"]
  min_size = 2
  max_size = 2
  load_balancers = ["${aws_elb.example.name}"]
  health_check_type = "ELB"
  health_check_grace_period = 300
}

resource "aws_elb" "example" {
  name = "terraform-asg-example"
  security_groups = ["${var.security_group_id}"]
  availability_zones = ["ap-south-1a"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
}
