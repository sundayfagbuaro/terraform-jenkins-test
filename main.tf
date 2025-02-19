provider "aws" {
    region = "eu-west-2"
    access_key = ""
  
}


resource "aws_instance" "jenkins-test-ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    key_name = "my-lab-key"
    security_groups = var.sgs_value
#    count = var.ec2_count

    tags = {
      Name = "jenkins-test-ec2"
    }

/*
    connection {
    type     = "ssh"
    user     = "ubuntu"
  #  private_key = file("/home/bobosunne/my-lab-key.pem")
    private_key = "my-lab-key"
    host     = self.public_ip
    
  }

  provisioner "file" {
    source = "installation_script.sh"
    destination = "/home/ubuntu/installation_script.sh"
    
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x installation_script.sh",
      "sudo ./installation_script.sh",
      "exit"
    ]  
  }
*/
}

