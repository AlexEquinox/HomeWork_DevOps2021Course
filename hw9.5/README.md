# HOME WORK #9.5 (AWS+Terraform)
## _Discrubing the Infrastructure Configuration with Terraform and then create it on AWS_
###(fixed issues with ingress and egress blocks, more info https://github.com/hashicorp/terraform-provider-aws/issues/8786)
```sh
provider "aws" {
  region     = "us-east-2"
  access_key = "AKIAXICIHK4CCPYWWLVL"
  secret_key = "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"
}

resource "aws_vpc" "dev_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
}

resource "aws_internet_gateway" "dev_gw" {
  vpc_id = aws_vpc.dev_vpc.id
}

resource "aws_route_table" "dev_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  route  {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.dev_gw.id
    }
  
    # {
    #   ipv6_cidr_block        = "::/0"
    #   egress_only_gateway_id = aws_internet_gateway.dev_gw.id
    # }
  
}

resource "aws_subnet" "dev_subnet" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"
}

resource "aws_route_table_association" "subnet_root-table_assoc" {
  subnet_id      = aws_subnet.dev_subnet.id
  route_table_id = aws_route_table.dev_route_table.id
} 


resource "aws_security_group" "allow_22_80_443" {
  name        = "allow_web"
  description = "Allow inbound web traffic(22,80,443 tcp)"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress = [
    {
      prefix_list_ids = null,
      security_groups = null,
      self = null,
      description      = "https to VPC"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },

    {
      prefix_list_ids = null,
      security_groups = null,
      self = null,
      description      = "http to VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },

    {
      prefix_list_ids = null,
      security_groups = null,
      self = null,
      description      = "ssh to VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  egress = [
    {
      description =  null,
      prefix_list_ids = null,
      security_groups = null,
      self= null,
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
  
}
  
resource "aws_network_interface" "prod_interface" {
  subnet_id       = aws_subnet.dev_subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_22_80_443.id]
}


resource "aws_eip" "prod_elastic_ip" {
  vpc      = true
  network_interface = aws_network_interface.prod_interface.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.dev_gw]
}

resource "aws_instance" "name" {
  ami           = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  availability_zone = "us-east-2a" 
  #key_name = ""
  network_interface {
    network_interface_id = aws_network_interface.prod_interface.id
    device_index         = 0
  }
  
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install apache2 -y
    sudo bash -c 'echo BLAH_BLAH_BLAH > /var/www/html/index.html'
  EOF
}


```

![docker ps](./img/bla_bla_bla.png)
![docker ps](./img/apply_success.png)


*****************************************************************
[✨✨✨✨✨✨ КОНСПЕКТ 9-9.5 ✨✨✨✨✨✨](./konspect_9.5.txt)
*****************************************************************
