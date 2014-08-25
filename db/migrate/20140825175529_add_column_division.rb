class AddColumnDivision < ActiveRecord::Migration
  def change
    add_column :divisions, :name, :string
    add_column :employees, :name, :string
  end
end
