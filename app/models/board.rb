# frozen_string_literal: true

# Board class
class Board < ApplicationRecord
  belongs_to :workspace
  has_many :lists, dependent: :destroy
  has_many :swimlanes, dependent: :destroy
  has_many :sorted_lists, -> { sorted }, class_name: "List"

  broadcasts_refreshes
end
