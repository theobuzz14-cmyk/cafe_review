class Cafe < ApplicationRecord
  self.table_name = "cafes"

  has_many :reviews, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :address, length: { maximum: 200 }, allow_blank: true
  validates :description, length: { maximum: 1000 }, allow_blank: true
end
