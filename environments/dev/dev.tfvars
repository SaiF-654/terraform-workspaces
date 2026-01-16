environment = "dev"
ami = "ami-0ecb62995f68bb549"
instance_count = 1
instance_type = "t2.micro"
ec2_username = "ubuntu"
key_name = "Terraform-dev-first"
ec2_sg = "allow_ssh_dev"
ssh_port = 22
tags = {
    Name = "Terraform-EC2"
    Environment = "dev"
}
volume_size = 15
volume_type = "gp3"