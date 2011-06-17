class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :user
      t.references :character
      t.text :body
      t.boolean :public

      t.timestamps
    end
  end
end
