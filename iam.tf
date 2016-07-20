# IAM role for ECS stuff
resource "aws_iam_role" "ecs_ingest" {
  name = "ecs_ingest"
  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
  {
    "Effect": "Allow",
    "Principal": {
      "Service": "ec2.amazonaws.com"
    },
    "Action": "sts:AssumeRole"
  }
]
}
EOF
}

# IAM policy for ECS stuff
resource "aws_iam_role_policy" "ecs_ingest" { 
  name = "ecs_instance_role"
  role = "${aws_iam_role.ecs_ingest.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:CreateCluster",
        "ecs:DeregisterContainerInstance",
        "ecs:DiscoverPollEndpoint",
        "ecs:Poll",
        "ecs:RegisterContainerInstance",
        "ecs:StartTelemetrySession",
        "ecs:Submit*",
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecs:StartTask"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# More IAM stuff...
resource "aws_iam_instance_profile" "ingest" {
  name = "ingest_profile"
  roles = ["${aws_iam_role.ecs_ingest.name}"]
}

