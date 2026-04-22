class Review < ApplicationRecord
  belongs_to :cafe

  validates :user_name, presence: true, length: { maximum: 50 }
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :body, presence: true, length: { maximum: 1000 }
end
