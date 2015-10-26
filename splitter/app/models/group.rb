class Group < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 5 , maximum: 25}
  has_many :memberships
  has_many :users, through: :memberships
  has_many :transactions, foreign_key: "group_id"
  accepts_nested_attributes_for :transactions
end
