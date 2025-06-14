output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.private : s.id]
}

output "public_ec2_ip" {
  value = aws_instance.public_ec2.public_ip
}

output "jenkins_url" {
  value = "http://${aws_lb.my_alb.dns_name}:8080/jenkins"
}