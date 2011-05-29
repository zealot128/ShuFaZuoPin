require 'test_helper'

class ExercisesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
