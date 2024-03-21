resource "aws_lb" "alb" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  # security_groups  =   var.security_group_ids
  subnets            = var.subnet_ids
  
  # vpc_id =var.vpc_id
  enable_deletion_protection = false
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

    }


resource "aws_lb_target_group" "target_group" {
  name        = var.target_group_name
  port        = 80
  protocol    = var.protocol
  vpc_id      = var.vpc_id  
  target_type = "instance"
    health_check {
    path                = "/"
    port                = 8080
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-499"
  }
}


resource "aws_lb_target_group_attachment" "target_attachment" {
  # count = length(module.my_instances1.instance_ids)
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_lb_target_group.target_group.id # Replace with your target instance ID
}