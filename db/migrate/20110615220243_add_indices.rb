class AddIndices < ActiveRecord::Migration
  def change
    add_index :notes, :user_id
    add_index :notes, :character_id
    add_index :notes, :public
    add_index :notes, [:public, :user_id, :character_id]

    add_index :characters, :type
    add_index :characters, :hanzi
    add_index :characters, :simplified
    add_index :characters, :traditional
  end
end
