output "security_scanner_instance_id" {
  description = "ID of the Security Scanner instance"
  value       = module.security_scanner.instance_id
}

output "security_scanner_public_ip" {
  description = "Public IP of the Security Scanner instance"
  value       = module.security_scanner.public_ip
}

output "security_scanner_subnet_id" {
  description = "Subnet ID where Security Scanner is deployed"
  value       = module.security_scanner.subnet_id
}

output "security_scanner_security_group_id" {
  description = "Security Group ID for Security Scanner"
  value       = module.security_scanner.security_group_id
}

output "ssh_key_name" {
  description = "Name of the generated SSH key pair"
  value       = aws_key_pair.jenkins_key.key_name
}

output "ssh_key_secret_name" {
  description = "Name of the secret containing the SSH private key"
  value       = aws_secretsmanager_secret.jenkins_key.name
}

output "jenkins_public_ip" {
  description = "Public IP of the Jenkins instance"
  value       = module.jenkins.jenkins_master_public_ip
}

output "jenkins_private_ip" {
  description = "Private IP of the Jenkins instance"
  value       = module.jenkins.jenkins_master_private_ip
}

output "jenkins_private_ip_cidr" {
  description = "CIDR block for Jenkins master private IP"
  value       = module.jenkins.jenkins_master_private_ip_cidr
}

output "jenkins_url" {
  description = "URL for Jenkins master"
  value       = module.jenkins.jenkins_url
}

output "jenkins_security_group_id" {
  description = "Security Group ID for Jenkins"
  value       = module.jenkins.jenkins_master_security_group_id
}

output "security_scanner_ssh_command" {
  description = "Command to SSH into the Security Scanner instance"
  value       = "aws secretsmanager get-secret-value --secret-id ${aws_secretsmanager_secret.jenkins_key.name} --query 'SecretString' --output text > jenkins-key.pem && chmod 400 jenkins-key.pem && ssh -i jenkins-key.pem ec2-user@${module.security_scanner.public_ip}"
}

output "jenkins_ssh_command" {
  description = "Command to SSH into the Jenkins instance"
  value       = "aws secretsmanager get-secret-value --secret-id ${aws_secretsmanager_secret.jenkins_key.name} --query 'SecretString' --output text > jenkins-key.pem && chmod 400 jenkins-key.pem && ssh -i jenkins-key.pem ec2-user@${module.jenkins.jenkins_master_public_ip}"
}

output "jenkins_admin_password" {
  description = "Command to retrieve the Jenkins admin password (dev environment only)"
  value       = var.environment == "dev" ? "aws secretsmanager get-secret-value --secret-id jenkins-admin-password-${var.environment} --query 'SecretString' --output text" : "Password retrieval disabled in this environment"
}

# Lambda Function Outputs
output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.security_scan_api.lambda_function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.security_scan_api.lambda_function_arn
}

output "lambda_invoke_url" {
  description = "Invoke URL for the Lambda function via API Gateway"
  value       = module.security_scan_api.api_gateway_invoke_url
}

output "api_gateway_id" {
  description = "ID of the API Gateway"
  value       = module.security_scan_api.api_gateway_id
}

output "api_gateway_stage_name" {
  description = "Name of the API Gateway stage"
  value       = module.security_scan_api.api_gateway_stage_name
}

output "api_gateway_endpoint" {
  description = "Full endpoint URL of the API"
  value       = module.security_scan_api.api_gateway_endpoint
} 