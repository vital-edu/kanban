class AddProgressToTasks < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.integer :progress
    end
  end
end
