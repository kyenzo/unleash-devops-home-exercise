output "ecs_cluster_name" {
  value = aws_ecs_cluster.evgeni_ecs_cluster.name
}

output "ecs_instance_public_ips" {
  value = aws_instance.ecs_instance.*.public_ip
}