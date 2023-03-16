class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validates :start_date, presence: true
  validates :start_date, inclusion: { in: Date.today.. }, if: -> { id.nil? }
  validates :end_date, presence: true, comparison: { greater_than: :start_date }
  validates :status, inclusion: %w[accepted pending rejected]

  def accepted?
    status == "accepted"
  end

  def pending?
    status == "pending"
  end

  def rejected?
    status == "rejected"
  end
end
