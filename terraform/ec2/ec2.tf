resource "aws_instance" "tf_demo_ec2" {
  count                       = var.ec2.instance_count
  ami                         = var.ec2.ami
  instance_type               = var.ec2.instance_type
  vpc_security_group_ids      = [aws_security_group.tf_demo_sg.id]
  subnet_id                   = aws_subnet.tf_demo_subnet.id
  key_name                    = aws_key_pair.key_pair.key_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.tf_demo_profile.name

  root_block_device {
    volume_type           = var.ec2.volume_type
    volume_size           = var.ec2.volume_size
    delete_on_termination = true
  }

  tags = {
    Name = "${var.app_name}-ec2"
  }
  depends_on = [aws_vpc.tf_demo_vpc, aws_subnet.tf_demo_subnet, aws_security_group.tf_demo_sg, aws_iam_instance_profile.tf_demo_profile]
}
