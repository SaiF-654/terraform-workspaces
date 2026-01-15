# SSH Key Name
output "key_name" {
  value = aws_key_pair.default.key_name
}

# EC2 Public IPs (dynamic list)
output "public_ips" {
  value = aws_instance.example[*].public_ip
}

# EC2 Instance IDs (dynamic list)
output "instance_ids" {
  value = aws_instance.example[*].id
}
