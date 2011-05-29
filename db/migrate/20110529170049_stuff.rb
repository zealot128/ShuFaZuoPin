class Stuff < ActiveRecord::Migration
  def change
    remove_column :characters, :examples
    change_column :characters, :translation, :text
  end

end
