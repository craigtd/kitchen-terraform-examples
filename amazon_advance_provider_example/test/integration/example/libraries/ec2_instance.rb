# frozen_string_literal: true

# Resource representing an EC2 instance
class EC2Instance < Inspec.resource 1
  name "ec2_instance"

  def security_groups
    inspec.command("curl http://169.254.169.254/latest/meta-data/security-groups").stdout
  end
end
