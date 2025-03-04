output "web_ip" {
  value = "${aws_instance.web.public_ip}"
}

output "ebs_volume_id" {
  value = aws_ebs_volume.ebs_volume.id
}