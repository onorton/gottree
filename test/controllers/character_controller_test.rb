require 'test_helper'

class CharacterControllerTest < ActionController::TestCase
  test "should get display" do
    get :display
    assert_response :success
  end

end
