class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one_attached :photo

  validates :year, presence: true, inclusion: { in: 1960..Date.today.year }, numericality: { only_integer: true }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1.0 }
  validates :user, presence: true
  validates :kilometers, presence: true
  validates :model, presence: true
  validates :photo, presence: true
end
