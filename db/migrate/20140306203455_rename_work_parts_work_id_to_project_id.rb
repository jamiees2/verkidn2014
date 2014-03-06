class RenameWorkPartsWorkIdToProjectId < ActiveRecord::Migration
  def change
    rename_column :work_parts, :work_id, :project_id
  end
end
