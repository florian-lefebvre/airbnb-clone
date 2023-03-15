class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all.order(created_at: :desc)
    end
  end

  def show?
    [record.user, record.car.user].include?(user)
  end

  def create?
    true
  end

  def update?
    [record.user, record.car.user].include?(user)
  end

  def destroy?
    record.user == user
  end

  def permitted_attributes
    if user == record.car.user
      [:status]
    elsif user == record.user
      %i[start_date end_date]
    end
  end
end
