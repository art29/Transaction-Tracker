class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.date :transaction_date
      t.float :price
      t.string :name
      t.references :category, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
