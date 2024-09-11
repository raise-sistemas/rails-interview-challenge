class Event < ApplicationRecord
  has_many :enrollments, dependent: :destroy
end
