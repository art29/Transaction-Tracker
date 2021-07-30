class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, presence: true # Name of transaction
  validates :transaction_date, presence: true # Date of transaction
  validates :price, presence: true # Price of transaction
  validates :category_id, presence: true # Category linked to the transaction
  validates :user_id, presence: true # user_id
end
