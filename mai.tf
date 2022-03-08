provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA57AAH6I5GUI3V2NR"
  secret_key = "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"
}
resource "aws_instance" "Tata-web" {
  ami           = "ami-0c6615d1e95c98aca"
  instance_type = "t2.micro"
  tags = {
    Name = "Tata-web"
  }
}
//
pipeline {
    agent any

    stages {
        stage('checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Papu-git/Terraform.git']]])
            }
        }
        stage('Terraform init') {
            steps {
                sh ("terraform init")
            }
        }
        stage('Terraform Action') {
            steps {
                echo "terraform action from the parameter is ----->${action}"
                sh ("terraform ${action} --auto-approve");
            }
        }
    }
}
//
 yum upgrade all
    2  sudo yum update –y
    3  udo wget -O /etc/yum.repos.d/jenkins.repo     https://pkg.jenkins.io/redhat-stable/jenkins.repo
    4  sudo wget -O /etc/yum.repos.d/jenkins.repo     https://pkg.jenkins.io/redhat-stable/jenkins.repo
    5  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    6  sudo yum upgrade
    7  yum install java-1.8.0
    8  sudo yum install jenkins -y
    9  yum install epel
   10  yum install epel-release
   11  sudo amazon-linux-extras install epel
   12  sudo yum install jenkins -y
   13  sudo systemctl start jenkins
   14  sudo systemctl status jenkins
   15  cat /var/lib/jenkins/secrets/initialAdminPassword
   16  sudo yum install -y yum-utils
   17  sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
   18  sudo yum -y install terraform
   19  ls
   20  terraform
   21  yum install git -y
   22  yum install git -y
   23  history


