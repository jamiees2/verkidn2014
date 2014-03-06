class CreateWorkParts < ActiveRecord::Migration
  def change
    create_table :work_parts do |t|
      t.string :name
      t.string :description
      t.integer :creator_id
      t.references :work
      t.timestamps
    end
  end
end
