class UpdateColumnEmployeeId < ActiveRecord::Migration
  def change
    remove_column :employees, :project_id
    add_column :projects, :employee_id, :integer
  end
end
