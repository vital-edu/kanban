class Stage < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  belongs_to :project
end
