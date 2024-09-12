class Event < ApplicationRecord
  has_many :enrollments, dependent: :destroy

  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
end
