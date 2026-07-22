resource "aws_ecs_cluster" "main" {

  name = "ecs-cicd-cluster"


  tags = {
    Name = "ecs-cicd-cluster"
  }
}


resource "aws_iam_role" "ecs_execution" {

  name = "ecs-cicd-task-execution-role"


  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ecs-tasks.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {

  role = aws_iam_role.ecs_execution.name


  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

}

resource "aws_ecs_task_definition" "app" {

  family = "ecs-cicd-task"


  requires_compatibilities = [
    "FARGATE"
  ]


  network_mode = "awsvpc"


  cpu = 256


  memory = 512


  execution_role_arn = aws_iam_role.ecs_execution.arn


  container_definitions = jsonencode([

    {

      name = "ecs-cicd-app"


      image = "${aws_ecr_repository.app.repository_url}:latest"


      essential = true


      portMappings = [

        {

          containerPort = 5000

          protocol = "tcp"

        }

      ]


      logConfiguration = {

        logDriver = "awslogs"


        options = {

          awslogs-group = aws_cloudwatch_log_group.ecs.name

          awslogs-region = "us-east-1"

          awslogs-stream-prefix = "ecs"

        }

      }

    }

  ])
}