output "public_ip" {
  value = aws_instance.tomcat_server.public_ip 
  description = "ec2 instance public-ip"
}