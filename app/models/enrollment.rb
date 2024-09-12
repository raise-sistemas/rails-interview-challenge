class Enrollment < ApplicationRecord
  belongs_to :event

  validate :event_capacity_not_exceeded

  private

  def event_capacity_not_exceeded
    if event.enrollments.count >= event.capacity
      errors.add(:base, "Event capacity has been reached.")
    end
  end
end
