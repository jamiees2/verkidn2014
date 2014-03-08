class AddDateToWorkLog < ActiveRecord::Migration
  def change
    add_column :work_logs, :date, :date
  end
end
