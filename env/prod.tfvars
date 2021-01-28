app_name = "terraform-demo"

availability_zone = "ap-northeast-2a"

vpc = {
    cidr: "192.168.0.0/16"
}

subnet = {
    cidr: "192.168.0.0/24"
}

ec2 = {
    instance_count: 1
    ami: "ami-09282971cf2faa4c9"
    instance_type: "t2.micro"
    key_name: "ops-interview-ap-ne-2"
    volume_size: 8
    volume_type: "gp2"
}
