class RemoveStatusFromTask < ActiveRecord::Migration
  def change
    remove_column :tasks, :status, :string
  end
end
