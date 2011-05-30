class AddHskLevelToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :hsk_level, :integer, :default => -1
  end
end
