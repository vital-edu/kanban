class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :stage
  validates :name, :priority, :description, presence: true
  validates :priority, numericality: { only_integer: true }
end
