class AddUserToWork < ActiveRecord::Migration
  def change
    # add_reference :works, :user, index: true
    add_column :works, :creator_id, :integer
    add_index :works, :creator_id
  end
end
