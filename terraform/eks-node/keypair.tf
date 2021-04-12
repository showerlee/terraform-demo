resource "aws_key_pair" "lt_key_pair" {
  key_name   = "${local.app_name}-launchtemplate-key"
  public_key = file("./tmp/id_rsa.pub")
}
