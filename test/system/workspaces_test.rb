# frozen_string_literal: true

require "application_system_test_case"

class WorkspacesTest < ApplicationSystemTestCase
  setup do
    @user = sign_in_as create(:user_with_workspace)
    @workspace = @user.workspaces.first
  end

  test "visiting the index" do
    visit workspaces_url

    assert_selector "h1", text: "Workspaces"
  end

  test "should create workspace" do
    visit workspaces_url
    click_on "New workspace"

    fill_in "Name", with: @workspace.name
    click_on "Create Workspace"

    assert_text "Workspace was successfully created"
    click_on "Back"
  end

  test "should update Workspace" do
    visit workspace_url(@workspace)
    click_on "Rename this workspace", match: :first

    fill_in "Name", with: @workspace.name
    click_on "Update Workspace"

    assert_text "Workspace was successfully updated"
    click_on "Back"
  end

  test "should destroy Workspace" do
    visit workspace_url(@workspace)

    accept_alert do
      click_on "Delete workspace", match: :first
    end

    assert_text "Workspace was successfully deleted"
  end
end
