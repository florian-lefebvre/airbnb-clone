class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validates :start_date, :end_date, presence: true, inclusion: { in: Date.today.. }
  validates :end_date, comparison: { greater_than: :start_date }
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
