class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, presence: true
  validates :transaction_date, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true
end
