class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :name, presence: true
  validates :income, inclusion: { in: [true, false] }
  validates :user_id, presence: true
end
