# frozen_string_literal: true

class Swimlane < ApplicationRecord
  belongs_to :board
  has_many :lists
  validates :title, presence: true
end
