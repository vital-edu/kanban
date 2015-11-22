class Project < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  has_many :tasks, dependent: :destroy
  has_many :stages, dependent: :destroy
  has_and_belongs_to_many :users

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :name, :description, :start_date, :end_date, :progress, presence: true
  validates :progress, numericality: true
  validate :deadline_is_possible?

  def deadline_is_possible?
      unless start_date.nil? || end_date.nil?
        if start_date > end_date
          errors.add(:start_date, 'must be before end_date')
        end
      end
  end

  attr_accessor :developers

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
