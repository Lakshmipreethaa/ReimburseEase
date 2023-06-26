class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.float :amount
      t.references :employee, null: false, foreign_key: true
      t.integer :bill_type

      t.timestamps
    end
  end
end
