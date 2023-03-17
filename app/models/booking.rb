class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validates :start_date, presence: true
  validate :validate_start_date
  validates :end_date, presence: true, comparison: { greater_than_or_equal_to: :start_date }
  validates :status, inclusion: %w[accepted pending rejected]
  validate :validate_no_overlap

  def accepted?
    status == "accepted"
  end

  def pending?
    status == "pending"
  end

  def rejected?
    status == "rejected"
  end

  def period
    start_date..end_date
  end

  private

  def validate_start_date
    creating = id.nil?
    has_error = false
    has_error = true if creating && start_date < Date.today
    has_error = false if !creating && start_date == start_date_was
    has_error = true if !creating && start_date != start_date_was && start_date < Date.today
    errors.add(:start_date, "can't be in the past") if has_error
  end

  def validate_no_overlap
    sql = ":end_date >= start_date and end_date >= :start_date"
    is_overlapping = Booking.where(car:, status: "accepted").where(sql, start_date:, end_date:).exists?
    errors.add(:start_date, "can't be used because it's already booked") if is_overlapping
    errors.add(:end_date, "can't be used because it's already booked") if is_overlapping
  end
end
