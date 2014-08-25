class CreateEmployee < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
    end
  end
end
