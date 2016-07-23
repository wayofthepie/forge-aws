# Jenkins task to run in the service
resource "aws_ecs_task_definition" "artifactory" {
  family = "artifactory"
  container_definitions = "${file("task-definitions/artifactory.json")}"

  volume {
    name = "artifactory"
    host_path = "/ecs/artifactory"
  }
}

# Jenkins ECS service
resource "aws_ecs_service" "artifactory" {
  name = "artifactory"
  cluster = "${aws_ecs_cluster.tools-cluster.id}"
  task_definition = "${aws_ecs_task_definition.artifactory.arn}"
  desired_count = 1
}

