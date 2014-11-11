class WelcomeControllerTest < ActionController::TestCase
  def setup
    @user = users(:user_1)
    sign_in @user
  end

  test "should redirect unsigned user to ticket creation page" do
    get :index
    assert_response :redirect
  end
end
