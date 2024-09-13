class Enrollment < ApplicationRecord
  include Cachable

  belongs_to :event

  validate :event_capacity_not_exceeded

  # Force association reload to get the updated count
  after_commit :reload_event

  private

  def event_capacity_not_exceeded
    return if event.available?

    errors.add(:base, "Event capacity has been reached.")
  end
end
