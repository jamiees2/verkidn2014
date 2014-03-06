class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_many :work_logs
end
