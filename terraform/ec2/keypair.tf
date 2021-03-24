resource "aws_key_pair" "key_pair" {
  key_name   = "terraform-demo-ec2-key"
  public_key = file("./tmp/id_rsa.pub")
}
