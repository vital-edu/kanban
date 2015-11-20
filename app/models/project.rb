class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :stages, dependent: :destroy
end
