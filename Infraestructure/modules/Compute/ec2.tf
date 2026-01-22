

resource "aws_instance" "ec2_instance" {
  ami                         = var.ec2_ami
  associate_public_ip_address = true
  instance_type               = var.ec2_instance_type
  vpc_security_group_ids      = [var.sg_base_ec2_id, var.sg_front_end_id]
  subnet_id                   = var.public_subnet1_id
  key_name                    = aws_key_pair.kp_config_user.key_name
  tags = {
    Name = "Wordpress Instance"
  }
  user_data = var.db_user_data
}


# Upload a Private Key Pair for SSH Instance Authentication
resource "aws_key_pair" "kp_config_user" {
  key_name   = "kp_config_user"
  public_key = file("${path.module}/id_rsa.pub")
}
