require "test_helper"

class EnrollmentTest < ActiveSupport::TestCase
  def setup
    @event = Event.create!(title: "Test Event", capacity: 2)
  end

  test "should save enrollment if event capacity is not exceeded" do
    enrollment = Enrollment.new(event: @event)
    assert enrollment.save, "Enrollment should be saved when event capacity is not exceeded"
  end

  test "should not save enrollment if event capacity is exceeded" do
    2.times { Enrollment.create!(event: @event) }
    enrollment = Enrollment.new(event: @event)
    assert_not enrollment.save, "Enrollment should not be saved when event capacity is exceeded"
    assert_includes enrollment.errors[:base], "Event capacity has been reached."
  end

  test "should allow multiple enrollments if capacity is not reached" do
    enrollment1 = Enrollment.new(event: @event)
    enrollment2 = Enrollment.new(event: @event)
    assert enrollment1.save, "First enrollment should be saved"
    assert enrollment2.save, "Second enrollment should be saved"
  end
end
