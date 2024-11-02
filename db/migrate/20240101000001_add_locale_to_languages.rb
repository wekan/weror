class AddLocaleToLanguages < ActiveRecord::Migration[7.2]
  def change
    add_column :languages, :locale, :string
  end
end
