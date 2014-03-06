class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :work_part
  has_many :work_logs
end
