class AddPhoneticToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :phonetic, :string
  end
end
