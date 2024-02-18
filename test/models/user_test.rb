# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:memberships).dependent(:destroy)
    should have_many(:workspaces).through(:memberships)
    should have_many(:sessions).dependent(:destroy)
  end

  context "validations" do
    subject { build(:user) }
    should validate_presence_of(:email)
    should validate_presence_of(:name)
    should validate_uniqueness_of(:email).ignoring_case_sensitivity
    should normalize(:email).from(" ME@XYZ.COM\n").to("me@xyz.com")
  end

  test "can access my workspaces via workspaces.mine" do
    user1 = create(:user_with_3_workspaces)

    assert_equal(3, user1.workspaces.mine.count)
  end

  test "can access others' workspaces via workspaces.others" do
    user1 = create(:user_with_3_workspaces)
    user2 = create(:user_with_3_workspaces)
    Membership.create(user: user1, workspace: user2.workspaces.first, role: Membership.roles[:editor])

    assert_equal(1, user1.workspaces.others.count)
  end
end
