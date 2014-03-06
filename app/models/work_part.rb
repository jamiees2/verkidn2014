class WorkPart < ActiveRecord::Base

  belongs_to :creator, :class_name => "User"
  belongs_to :work
  has_many :assignments
  has_many :users, :through => :assignments
end
