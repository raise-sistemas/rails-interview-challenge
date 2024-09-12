require "test_helper"

class EnrollmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @enrollment = enrollments(:one)
    @event = Event.create!(title: "Test Event", capacity: 1)
  end

  test "try to create an enrollment for an event that has reached its capacity" do
    Enrollment.create!(event: @event, email: "test1@example.com")

    assert_no_difference("Enrollment.count") do
      post enrollments_url, params: { enrollment: { email: "test2@example.com", event_id: @event.id } }
    end

    assert_response :unprocessable_entity
    assert_match /Event capacity has been reached/, response.body
  end

  test "should get index" do
    get enrollments_url
    assert_response :success
  end

  test "should get new" do
    get new_enrollment_url
    assert_response :success
  end

  test "should create enrollment" do
    assert_difference("Enrollment.count") do
      post enrollments_url, params: { enrollment: { email: @enrollment.email, event_id: @enrollment.event_id } }
    end

    assert_redirected_to enrollment_url(Enrollment.last)
  end

  test "should show enrollment" do
    get enrollment_url(@enrollment)
    assert_response :success
  end

  test "should get edit" do
    get edit_enrollment_url(@enrollment)
    assert_response :success
  end

  test "should update enrollment" do
    patch enrollment_url(@enrollment), params: { enrollment: { email: @enrollment.email, event_id: @enrollment.event_id } }
    assert_redirected_to enrollment_url(@enrollment)
  end

  test "should not update enrollment if event capacity is reached" do
    @event.update!(capacity: 1)
    Enrollment.create!(event: @event, email: "test1@example.com")

    patch enrollment_url(@enrollment), params: { enrollment: { email: "test2@example.com", event_id: @event.id } }

    assert_response :unprocessable_entity
    assert_match /Event capacity has been reached/, response.body
  end

  test "should destroy enrollment" do
    assert_difference("Enrollment.count", -1) do
      delete enrollment_url(@enrollment)
    end

    assert_redirected_to enrollments_url
  end
end
