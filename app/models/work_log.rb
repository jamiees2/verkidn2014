class WorkLog < ActiveRecord::Base
  belongs_to :assignment
  validates_uniqueness_of :date, :scope => :assignment_id
end
