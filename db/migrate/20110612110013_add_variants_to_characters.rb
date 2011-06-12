class AddVariantsToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :simplified, :string
    add_column :characters, :traditional, :string
  end
end
