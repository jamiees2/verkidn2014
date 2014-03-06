class CreateWorkLogs < ActiveRecord::Migration
  def change
    create_table :work_logs do |t|
      t.integer :hours
      t.text :description
      t.references :assignment, index: true

      t.timestamps
    end
  end
end
