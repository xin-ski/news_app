require "test_helper"

class AllnewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get allnews_index_url
    assert_response :success
  end
end
