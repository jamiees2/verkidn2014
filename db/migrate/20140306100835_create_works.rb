class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name
      t.string :description
      t.references :status, index: true

      t.timestamps
    end
  end
end
