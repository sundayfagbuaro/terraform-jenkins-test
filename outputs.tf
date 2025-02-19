/*
output "public_ips" {
    value = aws_instance.jenkins-hosts[each.key].public_ip
  
}

*/
output "jenkins-worker-pub-ip" {
    value = aws_instance.jenkins-test-ec2.public_ip
  
}

output "jenkins-worker-pub-ip" {
    value = aws_instance.jenkins-test-ec2.public_dns
  
}


