class RemoveColumnDueDateFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :due_date, :string
  end
end
