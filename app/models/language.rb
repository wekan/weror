# frozen_string_literal: true

class Language < ApplicationRecord
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
end
