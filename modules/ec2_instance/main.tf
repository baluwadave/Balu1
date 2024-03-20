# Define EC2 instances
resource "aws_instance" "my_instances" {
  depends_on = [ vpc.vpc_id ]
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id1
#   vpc_security_group_ids = [  ]
  key_name = var.key_name

  tags = {
    Name = "Instance-${count.index}"
  }
}
