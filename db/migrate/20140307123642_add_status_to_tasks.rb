class AddStatusToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :open, :boolean, default: true
  end
end
