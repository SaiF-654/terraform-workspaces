#Step 1 — Create Key Pair
resource "aws_key_pair" "default" {
  key_name   = var.key_name
  public_key = file(abspath(var.ssh_public_key_path))
}

# Step 2 — Create Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "${var.sg_name}-${var.env}"
  description = var.sg_description

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Step 3 — Create EC2 Instances
resource "aws_instance" "example" {
  count                  = var.instance_count
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

  tags = merge(
    var.tags,
   {
      Name = "${lookup(var.tags, "Name", "EC2")}-${count.index + 1}"
   }
 )

}
