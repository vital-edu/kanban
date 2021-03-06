class User < ActiveRecord::Base
  attr_accessor :role
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :projects

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def role?(role)
   return !!self.roles.find_by_name(role.to_s.titleize)
  end
end
