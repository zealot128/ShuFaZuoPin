class AddEtymologyToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :etymology, :string, :default => ""
  end
end
