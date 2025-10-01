output "alb_dns_name" {
  description = "DNS name of the load balancer - use this to access your app"
  value       = aws_lb.main.dns_name
}

output "alb_url" {
  description = "Full URL to access the application"
  value       = "http://${aws_lb.main.dns_name}"
}

output "ecr_repository_url" {
  description = "ECR repository URL for pushing Docker images"
  value       = aws_ecr_repository.app.repository_url
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.main.name
}

output "cloudwatch_log_group" {
  description = "CloudWatch log group name"
  value       = aws_cloudwatch_log_group.app.name
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "docker_push_commands" {
  description = "Commands to push Docker image to ECR"
  value = <<-EOT
    # Login to ECR
    aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.app.repository_url}
    
    # Build Docker image
    docker build -t ${var.project_name}-app .
    
    # Tag image
    docker tag ${var.project_name}-app:latest ${aws_ecr_repository.app.repository_url}:latest
    
    # Push to ECR
    docker push ${aws_ecr_repository.app.repository_url}:latest
  EOT
}