# frozen_string_literal: true

security_group = attribute "security_group", {}
overridden_security_group = attribute "overridden_security_group", {}

control "remote_security_group" do
  describe "the `security_group` output" do
    subject do ec2_instance.security_groups end

    it "is mapped to the `security_group` attribute" do is_expected.to eq security_group end

    it "equals the `overridden_security_group` attribute" do is_expected.to eq overridden_security_group end
  end
end
