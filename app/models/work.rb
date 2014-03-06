class Work < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  belongs_to :status
  has_many :work_parts, :dependent => :destroy
end
