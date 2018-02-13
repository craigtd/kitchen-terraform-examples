output "reachable_other_host_public_ip" {
  description = "The public IP address of the reachable_other_host instance"
  value       = "${aws_instance.reachable_other_host.public_ip}"
}

output "security_group" {
  description = "The name of the security group"
  value       = "${aws_security_group.example.name}"
}

output "terraform_state" {
  description = "The path to the Terraform state file"
  value       = "${path.module}/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
}

output "test_target_public_dns" {
  description = "The list of public DNS names assigned to the test_target instances"
  value       = ["${aws_instance.test_target.*.public_dns}"]
}

