resource "aws_lb" "my_alb" {
 internal           = false
 load_balancer_type = "application"
 security_groups    = [aws_security_group.alb_sg.id]
 subnets            = [aws_subnet.public["1"].id, aws_subnet.public["0"].id]

 tags = {
   Name = "${var.env}-alb"
 }
}

resource "aws_lb_target_group" "alb_tg" {
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/jenkins/login"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.env}-tg"
  }
}

resource "aws_lb_target_group" "alb_tg2" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.env}-tg"
  }
}

resource "aws_lb_target_group_attachment" "tg_attach2" {
  target_group_arn = aws_lb_target_group.alb_tg2.arn
  target_id        = aws_instance.private_ec2_2.id
  port             = 80
}
resource "aws_lb_listener" "alb_list2" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg2.arn
  }
}

resource "aws_lb_target_group_attachment" "tg_attach" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.private_ec2_1.id
  port             = 8080
}

resource "aws_lb_listener" "alb_list" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

resource "aws_lb_listener_rule" "jenkins" {
  listener_arn = aws_lb_listener.alb_list.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }

  condition {
    path_pattern {
      values = ["/jenkins*"]
    }
  }
}
