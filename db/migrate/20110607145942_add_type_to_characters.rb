class AddTypeToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :type, :string, :default => "Character"
  end
end
