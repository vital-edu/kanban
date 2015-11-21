class ProjectsHaveAndBelongsToManyUsers < ActiveRecord::Migration
  def change
    create_table :projects_users, :id => false do |t|
      t.references :project, :user
    end
  end
end
