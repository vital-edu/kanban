class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :stage
  validates :name, :priority, :description, presence: true
  validates :priority, numericality: { only_integer: true }

  after_commit :update_project_progress

private
  def update_project_progress
    Project.find(self.project.id).update_progress
  end
end
