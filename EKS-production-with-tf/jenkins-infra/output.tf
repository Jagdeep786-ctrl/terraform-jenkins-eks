output "ec2_public_ip" {
  value       = aws_instance.my-instance.public_ip
  description = "Public IP address of the EC2 instance"
}

output "ec2_private_ip" {
  value       = aws_instance.my-instance.private_ip
  description = "Private IP address of the EC2 instance"

}

output "ec2_public_dns" {
  value       = aws_instance.my-instance.public_dns
  description = "Public DNS of the EC2 instance"
}