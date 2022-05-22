output "endpoint" {
  value = aws_lb.todo_app.dns_name
}

output "db-public-ip" {
  value = aws_instance.db.public_ip
}
output "web-public-ip" {
  value = aws_instance.web.public_ip
}

output "db_endpoint" {
  value = aws_rds_cluster.postgresql.endpoint
}

output "dynanoDb_endpoint" {
  value = "https://dynamodb.us-east-1.amazonaws.comLinksLinks"
}