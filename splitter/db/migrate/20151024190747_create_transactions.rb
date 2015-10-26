class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :debtor_id
      t.string :creditor_id
      t.string :note
      t.float :amount

      t.timestamps null: false
    end
  end
end
