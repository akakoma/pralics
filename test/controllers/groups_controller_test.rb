require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get groups_about_url
    assert_response :success
  end

end
