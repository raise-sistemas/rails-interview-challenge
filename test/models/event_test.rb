require "test_helper"

class EventTest < ActiveSupport::TestCase
  setup do
    @event = events(:one)
  end

  test "should be valid with valid attributes" do
    assert @event.valid?
  end

  test "should not be valid without capacity" do
    @event.capacity = nil
    assert_not @event.valid?
  end

  test "should not be valid with non-integer capacity" do
    @event.capacity = "ten"
    assert_not @event.valid?
  end

  test "should not be valid with capacity less than or equal to zero" do
    @event.capacity = 0
    assert_not @event.valid?
  end

  test "should destroy associated enrollments" do
    assert_difference("Enrollment.count", -@event.enrollments.count) do
      @event.destroy
    end
  end
end
