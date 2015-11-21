class Project < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  has_many :tasks, dependent: :destroy
  has_many :stages, dependent: :destroy
  has_and_belongs_to_many :users

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
