# frozen_string_literal: true

module RoleEnum
  extend ActiveSupport::Concern

  included do
    enum :role, [:owner, :admin, :editor, :viewer]

    validates :role, inclusion: { in: roles.keys }
  end
end
