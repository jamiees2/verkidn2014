class AddOpenIndexToTasks < ActiveRecord::Migration
  def change
    add_index :tasks, :open
  end
end
