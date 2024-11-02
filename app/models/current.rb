# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :user
  attribute :user_agent
  attribute :ip_address
  attribute :session
end
