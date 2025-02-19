
variable "ami_id" {
    default = "ami-091f18e98bc129c4e"
  
}

variable "instance_type" {
    default = "t2.micro"
  
}

variable "subnet_id" {
    default = "subnet-032926b7963f02cd6"
  
}

variable "sgs_value" {
    default = ["sg-04ce3a9c3d658c0cd"]
  
}

#variable "ec2_count" {
#    default = 1
  
#}

variable "tags_value" {
    default = "jenkins-host"
}


/*
variable "foreach" {
    default = {
        jenkins-master = {
            ami_id = "ami-091f18e98bc129c4e"
            instance_type = "t2.micro"
            subnet_id = "subnet-032926b7963f02cd6"
            security_groups = ["sg-04ce3a9c3d658c0cd"]

        }
        jenkins-worker = {
            ami_id = "ami-091f18e98bc129c4e"
            instance_type = "t2.micro"
            subnet_id = "subnet-032926b7963f02cd6"
            security_groups = ["sg-04ce3a9c3d658c0cd"]
        }
  
    }
}
*/

