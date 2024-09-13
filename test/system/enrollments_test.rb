require "application_system_test_case"

class EnrollmentsTest < ApplicationSystemTestCase
  setup do
    @enrollment = enrollments(:one)
  end

  test "visiting the index" do
    visit enrollments_url
    assert_selector "h1", text: "Enrollments"
  end

  test "should not create enrollment if event is at capacity" do
    event = events(:one)
    event.update(capacity: 1)
    Enrollment.create!(email: "test@example.com", event: event)

    visit new_enrollment_url
    fill_in "Email", with: "another_test@example.com"
    fill_in "Event", with: event.id
    click_on "Create Enrollment"

    assert_text "Event has reached its capacity"
  end

  test "should create enrollment" do
    visit enrollments_url
    click_on "New enrollment"

    fill_in "Email", with: @enrollment.email
    fill_in "Event", with: @enrollment.event_id
    click_on "Create Enrollment"

    assert_text "Enrollment was successfully created"
    click_on "Back"
  end

  test "should update Enrollment" do
    visit enrollment_url(@enrollment)
    click_on "Edit this enrollment", match: :first

    fill_in "Email", with: @enrollment.email
    fill_in "Event", with: @enrollment.event_id
    click_on "Update Enrollment"

    assert_text "Enrollment was successfully updated"
    click_on "Back"
  end

  test "should destroy Enrollment" do
    visit enrollment_url(@enrollment)
    click_on "Destroy this enrollment", match: :first

    assert_text "Enrollment was successfully destroyed"
  end
end
