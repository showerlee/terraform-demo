output "public_ip" {
  value = aws_instance.tf_demo_ec2[0].public_ip
}
