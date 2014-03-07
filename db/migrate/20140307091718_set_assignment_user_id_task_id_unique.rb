class SetAssignmentUserIdTaskIdUnique < ActiveRecord::Migration
  def change
    add_index :assignments, [:user_id,:task_id], :unique => true
  end
end
