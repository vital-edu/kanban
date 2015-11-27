class AddColumnIsActiveToTaskAndProject < ActiveRecord::Migration
  def change
    add_column :tasks, :is_active, :boolean, :default => true
    add_column :projects, :is_active,  :boolean, :default => true
  end
end
