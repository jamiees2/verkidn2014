class Project < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  belongs_to :status
  has_many :tasks, :dependent => :destroy
  validates :name, presence: true
end
