# frozen_string_literal: true

class AddLanguageToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :language, :string, default: "en"
  end
end
