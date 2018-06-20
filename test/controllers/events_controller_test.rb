require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get events_about_url
    assert_response :success
  end

end
