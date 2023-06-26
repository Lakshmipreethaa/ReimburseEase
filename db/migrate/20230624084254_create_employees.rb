class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.references :department, null: false, foreign_key: true
      t.references :designation, null: false, foreign_key: true
      t.boolean :is_deleted, default: false

      t.timestamps
    end
  end
end
