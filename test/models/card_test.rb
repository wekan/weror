# frozen_string_literal: true

require "test_helper"

class CardTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:list)
  end

  test "should be valid with no color" do
    card = Card.new
    card.list = List.new

    assert_predicate card, :valid?
  end
end
