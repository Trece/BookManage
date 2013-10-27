require 'test_helper'

class LibManageControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

end
