resource "aws_ecr_repository" "app" {
  name = "ecs-cicd-demo"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project = "aws-ecs-cicd-webapp"
  }
}