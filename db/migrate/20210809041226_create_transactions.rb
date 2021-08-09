class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.float :amount_spent
      t.integer :merchant_id
      t.string :bill_number
      t.string :payment_type

      t.timestamps
    end
  end
end
