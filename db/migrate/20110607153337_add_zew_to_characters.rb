class AddZewToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :zew, :string
  end
end
