class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :name

      t.timestamps null: false
    end

    add_reference :tasks, :stage, index:true
  end
end
