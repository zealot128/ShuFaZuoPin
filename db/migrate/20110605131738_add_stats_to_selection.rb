class AddStatsToSelection < ActiveRecord::Migration
  def change
    add_column :selections, :stats, :text
  end
end
