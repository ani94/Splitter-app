class Transaction < ActiveRecord::Base
  validates :debtor_id, presence: true
  validates :creditor_id, presence: true
  validates :note, presence: true, length: { minimum: 5, maximum: 25 }
  validates :amount, presence: true

  belongs_to :group
  belongs_to :user
end
