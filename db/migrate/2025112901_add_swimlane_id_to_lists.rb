class AddSwimlaneIdToLists < ActiveRecord::Migration[7.2]
  def change
    add_reference :lists, :swimlane, foreign_key: true
  end
end
