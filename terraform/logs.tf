resource "aws_cloudwatch_log_group" "ecs" {

  name = "/ecs/ecs-cicd-demo"


  retention_in_days = 7


  tags = {
    Name = "ecs-cicd-log-group"
  }
}