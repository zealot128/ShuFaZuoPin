class AddStuffToChars < ActiveRecord::Migration
  def change
    add_column :characters, :freq, :integer
    add_column :characters, :norm_pinyin, :string
    add_column :characters, :tone, :integer

  end
end
