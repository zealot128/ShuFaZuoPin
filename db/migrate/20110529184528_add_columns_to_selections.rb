class AddColumnsToSelections < ActiveRecord::Migration
  def change
    add_column :selections, :level_1, :integer, :default => 0
    add_column :selections, :level_2, :integer, :default => 0
    add_column :selections, :level_3, :integer, :default => 0
    add_column :selections, :next_visit_1, :datetime
    add_column :selections, :next_visit_2, :datetime
    add_column :selections, :next_visit_3, :datetime
  end
end
