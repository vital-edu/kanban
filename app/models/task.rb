class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :stage
  validates :name, :priority, :description, presence: true
  validate :validate_priority

  after_save :update_project_progress

  def priority_list
    ['Baixa', 'Média', 'Alta']
  end

private
  def validate_priority
    if priority_list.index(self.priority).nil?
      errors.add("Prioridade", " inválida")
    end
  end

  def update_project_progress
    Project.find(self.project.id).update_progress
  end
end
