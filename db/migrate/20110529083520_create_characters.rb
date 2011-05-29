class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :pinyin
      t.string :hanzi
      t.string :translation
      t.text :examples

      t.timestamps
    end
  end
end
