# frozen_string_literal: true

# List Class
class List < ApplicationRecord
  include RankedModel

  belongs_to :board, touch: true
  belongs_to :swimlane, optional: true
  has_many :cards, dependent: :destroy
  has_many :sorted_cards, -> { sorted }, class_name: "Card"

  scope :sorted, -> { order(row_order: :asc) }

  ranks :row_order, with_same: :board_id
end
