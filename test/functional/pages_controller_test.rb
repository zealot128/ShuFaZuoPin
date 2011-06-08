require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get impressum" do
    get :impressum
    assert_response :success
  end

end
