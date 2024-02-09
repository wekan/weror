# frozen_string_literal: true

require "application_system_test_case"

class BoardsTest < ApplicationSystemTestCase
  setup do
    @user = sign_in_as(create(:user_with_workspaces))
    @workspace = @user.workspaces.first
    @board = @workspace.boards.create(name: "Test Board")
  end

  test "visiting the index" do
    visit workspace_boards_url(@workspace)

    assert_selector "h1", text: "Boards"
  end

  test "should create board" do
    visit workspace_boards_url(@workspace)
    click_on "New board"

    fill_in "Name", with: @board.name
    click_on "Create Board"

    assert_text "Board was successfully created"
    click_on "Back"
  end

  test "should update Board" do
    visit board_url(@board)
    click_on "Edit this board", match: :first

    fill_in "Name", with: @board.name
    click_on "Update Board"

    assert_text "Board was successfully updated"
    click_on "Back"
  end

  test "should destroy Board" do
    visit board_url(@board)
    click_on "Destroy this board", match: :first

    assert_text "Board was successfully destroyed"
  end
end