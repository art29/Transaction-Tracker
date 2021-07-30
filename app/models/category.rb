class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :name, presence: true # Name of category
  validates :income, inclusion: { in: [true, false, nil] } # Type of income (Income, Expense, Neutral)
  validates :user_id, presence: true # user_id (A category is specific for to a user)
end
