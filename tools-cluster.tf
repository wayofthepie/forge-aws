
# Create an ECS cluster.
resource "aws_ecs_cluster" "tools-cluster" {
  name = "tools-cluster"
}

# Add nodes to our ECS cluster
resource "aws_instance" "tools-cluster-node" {
  ami   = "ami-c74127b4"
  count = 1
  instance_type = "t2.medium"
  tags {
    Name = "tools-cluster-node"
  }
  security_groups = [ "http-ssh" ]
  user_data = "${file("init/tools-cluster-node.sh")}"
  key_name = "control-keypair"
  iam_instance_profile = "${aws_iam_instance_profile.ingest.name}"
}

