class User < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 5, maximum:25}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :contact_number , presence: true, length: {is: 10 }, uniqueness: true
  before_save { self.email = email.downcase }
  has_secure_password
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :debts, class_name: "Transaction" , foreign_key: "debtor_id", dependent: :destroy
  has_many :credits, class_name: "Transaction" , foreign_key: "creditor_id", dependent: :destroy
end
