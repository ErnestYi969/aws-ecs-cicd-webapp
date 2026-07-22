resource "aws_lb" "main" {

  name = "ecs-cicd-alb"

  load_balancer_type = "application"

  internal = false


  security_groups = [
    aws_security_group.alb.id
  ]


  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]


  tags = {
    Name = "ecs-cicd-alb"
  }
}

resource "aws_lb_target_group" "app" {

  lifecycle {
    create_before_destroy = true
  }

  name = "ecs-cicd-tg-v2"

  port = 5000

  protocol = "HTTP"

  target_type = "ip"

  vpc_id = aws_vpc.main.id


  health_check {

    path = "/"

    protocol = "HTTP"

    matcher = "200"

  }


  tags = {
    Name = "ecs-cicd-tg"
  }
}

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.main.arn


  port = 80

  protocol = "HTTP"


  default_action {

    type = "forward"


    target_group_arn = aws_lb_target_group.app.arn

  }
}