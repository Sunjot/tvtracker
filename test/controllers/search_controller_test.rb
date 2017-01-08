require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get query" do
    get search_query_url
    assert_response :success
  end

end
