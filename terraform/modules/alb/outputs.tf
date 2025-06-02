output "backend_listener_rule_arn" {
  value = aws_lb_listener_rule.backend_rule.arn
}

output "messaging_listener_rule_arn" {
  value = aws_lb_listener_rule.messaging_rule.arn
}

output "backend_target_group_arn" {
  value = aws_lb_target_group.backend.arn
}

output "messaging_target_group_arn" {
  value = aws_lb_target_group.messaging.arn
}
