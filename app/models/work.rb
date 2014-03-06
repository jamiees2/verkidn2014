class Work < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  belongs_to :status

end
