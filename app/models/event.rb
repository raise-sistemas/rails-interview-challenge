class Event < ApplicationRecord
  include Cachable

  has_many :enrollments, dependent: :destroy

  validates :capacity, numericality: { only_integer: true, greater_than: 0 }

  scope :availables, -> {
    left_joins(:enrollments)
      .group("events.id")
      .having("COUNT(enrollments.id) < events.capacity")
  }

  # Using cache to avoid multiple queries to fetch available events
  # Imagining that the list of events is not updated frequently and
  # most users not enroll properly, I think it's a good approach
  # Plus: Cache is updated when event or enrollment is created
  # See more in app/models/concerns/cachable.rb Cachable concern
  def self.availables_cache
    Rails.cache.fetch("available_events", expires_in: 2.minutes) do
      Event.availables.to_a
    end
  end

  def available?
    total_enrollments < capacity
  end

  def total_enrollments
    enrollments.count
  end
end
