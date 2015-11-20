class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :project, index:true
      t.string :name
      t.string :priority
      t.string :description
      t.string :status
      t.datetime :creationDate

      t.timestamps true
    end
  end
end
