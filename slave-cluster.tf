# Aws provider config
provider "aws" {
  region = "eu-west-1"
}

# Create an ECS cluster.
resource "aws_ecs_cluster" "slave-cluster" {
  name = "slave-cluster"
}

# Add nodes to our ECS cluster
resource "aws_instance" "slave-cluster-node" {
  ami   = "ami-c74127b4"
  count = 2
  instance_type = "t2.micro"
  tags {
    Name = "swarm"
  }
  security_groups = [ "http-ssh" ]
  user_data = "${file("init/slave-cluster-node.sh")}"
  key_name = "control-keypair"
  iam_instance_profile = "${aws_iam_instance_profile.ingest.name}"
}

