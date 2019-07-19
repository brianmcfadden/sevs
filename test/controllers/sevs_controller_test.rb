require 'test_helper'

class SevsControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get sevs_main_url
    assert_response :success
  end

end
