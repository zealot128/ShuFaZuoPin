class Indices1 < ActiveRecord::Migration
  def change
    add_index :characters, :hsk_level
    add_index :characters, :pinyin
    add_index :characters, :norm_pinyin
    add_index :selections, :character_id
    add_index :selections, :user_id
    add_index :selections, :level_1
    add_index :selections, :level_2
    add_index :selections, :level_3
    add_index :selections, :next_visit_1
    add_index :selections, :next_visit_2
    add_index :selections, :next_visit_3
  end

end
