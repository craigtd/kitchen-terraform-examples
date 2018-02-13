# frozen_string_literal: true

require "awspec"

control "local_security_group" do
  describe "the security group" do
    let :example_security_group do security_group "kitchen-terraform-example" end

    describe "ingress" do
      subject do example_security_group.inbound end

      it "is open to the world" do is_expected.to be_opened.for "0.0.0.0/0" end
    end

    describe "egress" do
      subject do example_security_group.outbound end

      it "is open to the world" do is_expected.to be_opened.for "0.0.0.0/0" end
    end
  end
end

