class Project < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  has_many :tasks, dependent: :destroy
  has_many :stages, dependent: :destroy
  has_and_belongs_to_many :users

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  attr_accessor :developers
  attr_accessor :scrum_master

  after_create :create_default_stages
  before_save :update_developers

  def developers_list
    developers = Array.new
    Role.find_by(name: "Developer").users.each do |d|
      if self.users.find_by_id(d.id).present?
        developers.push(d.id)
      end
    end
    developers
  end

  def scrum_master
    self.users.each do |u|
      if u.roles.find_by(name: "Scrum Master").present?
        return u.id
      end
    end
  end

  def developers_list_object
    developers = Array.new
    Role.find_by(name: "Developer").users.each do |d|
      if self.users.find_by_id(d.id).present?
        developers.push(d)
      end
    end
    developers
  end

private
  def create_default_stages
    self.stages << Stage.create(name: "To Do")
    self.stages << Stage.create(name: "Doing")
    self.stages << Stage.create(name: "Done")
  end

  def update_developers
    developers.pop() # Fix-me, I am needed because the  developers array came with a empty element.

    current_developers = developers_list

    # Removes the developers that are not in the project anymore
    (current_developers - developers).each do |d|
      self.users.delete(d)
    end

    # Adds the new developers
    (developers - current_developers).each do |d|
      self.users << User.find(d)
    end
  end
end
