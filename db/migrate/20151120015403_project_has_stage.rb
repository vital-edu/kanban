class ProjectHasStage < ActiveRecord::Migration
  def change
    add_reference :stages, :project, index:true
  end
end
