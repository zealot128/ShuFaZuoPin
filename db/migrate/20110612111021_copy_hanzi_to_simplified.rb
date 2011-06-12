class CopyHanziToSimplified < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute('update characters set simplified=hanzi')
  end

  def down
  end
end
