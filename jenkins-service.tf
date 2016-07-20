# Jenkins task to run in the service
resource "aws_ecs_task_definition" "jenkins" {
  family = "jenkins"
  container_definitions = "${file("task-definitions/jenkins.json")}"

  volume {
    name = "jenkins-home"
    host_path = "/ecs/jenkins-home"
  }
}

# Jenkins ECS service
resource "aws_ecs_service" "jenkins" {
  name = "jenkins"
  cluster = "${aws_ecs_cluster.slave-cluster.id}"
  task_definition = "${aws_ecs_task_definition.jenkins.arn}"
  desired_count = 1
}

