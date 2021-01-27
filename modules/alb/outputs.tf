output "alb_id" {
  value = aws_lb.alb.id
}

output "alb_target_group_id" {
  value = aws_lb_target_group.webgroup.id
}