resource "aws_security_group" "AllowAll" {
  name        = "Webserverfromterraform"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "Webserver ports enabled"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "Webserver ports enabled"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "Webserver ports enabled"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Webserverports"
  }
}

resource "aws_instance" "Springpetclinic" {
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.AllowAll.id]
  key_name = "demo"

  tags = {
    Name = "SpringpetclinicVM2"
  }
   
  connection {
        user        = "ubuntu"
        host        = self.public_ip
        private_key = "${file("./demo.pem")}"
    }

 provisioner "file" {
    source      = "scripts/"
    destination = "/home/ubuntu/"
  }
  
    provisioner "remote-exec" {
        inline = [
           "sudo pwd",
           "sudo ls -la",
           "sudo chmod 755 /home/ubuntu/run.sh",
            "sudo sh /home/ubuntu/run.sh"
            #"sudo apt-get update",
            #"sudo apt-get install openjdk-11-jre openjdk-11-jdk-headless libxt-dev openjdk-11-jdk -y",
            #"sudo wget --user=issuesaws@gmail.com --password=cmVmdGtuOjAxOjAwMDAwMDAwMDA6RkJ3cGZXTnQycUhtbGVsMjRrSTRFbTc3MjNP https://springprtclinicproject.jfrog.io/artifactory/adminadmin/org/springframework/samples/spring-petclinic/2.7.3/spring-petclinic-2.7.3.jar",
            #"nohup sudo java -jar spring-petclinic-2.7.3.jar &"
            ]
    }
    

}

/*
resource "null_resource" "provision_ec2" {
  triggers = {
    public_ip = aws_instance.Springpetclinic.public_ip
  }

  provisioner "local-exec" {
    connection {
      type        = "ssh"
      agent       = false
      host        = self.triggers.public_ip
      user        = "ubuntu"
      private_key = "${file("./demo.pem")}"
    }
    inline = [
      "sudo ls -la",
      "sudo chmod 755 springpetclinic.sh javamaveninstallation.sh startservice.sh",
      "sudo sh run.sh"
    ]
    
  }
}
*/