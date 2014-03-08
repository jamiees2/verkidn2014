class SetDateUniqueWorkLog < ActiveRecord::Migration
  def change
    add_index :work_logs, [:assignment_id, :date], :unique => true
  end
end
