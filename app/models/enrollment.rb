class Enrollment < ApplicationRecord
  include Validates::Enrollments::Capacity
  validate :full_capacity

  belongs_to :event
end
