class AddGroupToTransaction < ActiveRecord::Migration
  def change
    add_reference :transactions, :group, index: true, foreign_key: true
  end
end
