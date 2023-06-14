resource "aws_instance" "tomcat_server" {
  ami           = "ami-07fb9d5c721566c65"
  instance_type = "t2.micro"
  key_name      = "realmen12345"
  vpc_security_group_ids = [aws_security_group.tomcat_sg.id]

  user_data = <<-EOF
#!/bin/bash
cd /opt
sudo yum install git vim wget -y
sudo yum install java-1.8.0-openjdk-devel -y
sudo yum install wget unzip -y
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.76/bin/apache-tomcat-9.0.76.zip
sudo unzip apache-tomcat-9.0.76.zip
sudo rm -rf apache-tomcat-9.0.76.zip
sudo mv apache-tomcat-9.0.76 tomcat9
sudo chmod 777 -R /opt/tomcat9
sudo chown ec2-user -R /opt/tomcat9
sudo /opt/tomcat9/bin/startup.sh
sudo ln -s /opt/tomcat9/bin/startup.sh /usr/bin/starttomcat
sudo ln -s /opt/tomcat9/bin/shutdown.sh /usr/bin/stoptomcat
starttomcat
sudo su - ec2-user
EOF

  tags = {
    Name = "tomcat"
  }
}
