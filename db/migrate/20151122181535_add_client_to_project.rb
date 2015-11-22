class AddClientToProject < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.string :customer
    end

    change_column :projects, :description, :text
  end
end
