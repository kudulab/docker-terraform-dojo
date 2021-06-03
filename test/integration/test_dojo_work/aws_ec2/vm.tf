data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "vm" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3a.nano"
}

resource "null_resource" "provision_vm" {
  depends_on = [aws_instance.vm]

  connection {
    type = "ssh"
    host = aws_instance.vm.public_ip
    user = "ubuntu"
  }
}

output "vm_ip" {
  value = aws_instance.vm.public_ip
}
