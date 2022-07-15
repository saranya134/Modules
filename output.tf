output "public_ip" {
  value = aws_instance.my-ec2-vm.*.public_ip
}
 
output "ec2_ID" {
  value = aws_instance.my-ec2-vm.*.id
}
 
output "ec2-arn" {
  value = aws_instance.my-ec2-vm.*.arn
}
 
output "private-ip" {
  value = aws_instance.my-ec2-vm.*.private_ip
}
 


 
