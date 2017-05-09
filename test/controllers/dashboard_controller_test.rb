require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get display" do
    get dashboard_display_url
    assert_response :success
  end

end
