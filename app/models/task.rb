class Task < ActiveRecord::Base

  belongs_to :creator, :class_name => "User"
  belongs_to :projects
  has_many :assignments, dependent: :destroy
  has_many :users, :through => :assignments
end
