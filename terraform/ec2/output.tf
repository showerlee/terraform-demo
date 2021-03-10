output "public_ip" {
  value = aws_instance.tf_demo_ec2[0].public_ip
}

output "ssh_key" {
  value = aws_instance.tf_demo_ec2[0].key_name
}

output "ami" {
  value = aws_instance.tf_demo_ec2[0].ami
}

output "instance_type" {
  value = aws_instance.tf_demo_ec2[0].instance_type
}
