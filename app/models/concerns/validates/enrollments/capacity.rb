module Validates::Enrollments::Capacity
  extend ActiveSupport::Concern

  def full_capacity
    self.errors.add(:base, "event with full capacity of enrollments") if self.event.enrollments.count >= self.event.capacity
  end
end
