# frozen_string_literal: true

reachable_other_host_public_ip =
  attribute(
    "reachable_other_host_public_ip",
    {}
  )

control "reachable_other_host" do
  describe "the other host" do
    subject do
      host reachable_other_host_public_ip
    end

    it do
      is_expected.to be_reachable
    end
  end
end

