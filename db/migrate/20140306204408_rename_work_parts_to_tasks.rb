class RenameWorkPartsToTasks < ActiveRecord::Migration
  def change
    rename_table :work_parts, :tasks
    rename_column :assignments, :work_part_id, :task_id
  end
end
