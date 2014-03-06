class UserHasWorkParts < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :user, :work_part
      t.timestamps
    end
  end
end
