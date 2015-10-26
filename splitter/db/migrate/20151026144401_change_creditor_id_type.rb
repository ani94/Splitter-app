class ChangeCreditorIdType < ActiveRecord::Migration
  def change
    change_column :transactions, :creditor_id, :integer
  end
end
