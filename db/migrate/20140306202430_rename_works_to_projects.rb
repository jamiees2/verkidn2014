class RenameWorksToProjects < ActiveRecord::Migration
  def change
      rename_table :works, :projects
  end
end
