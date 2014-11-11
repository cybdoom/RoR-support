class WelcomeControllerTest < ActionController::TestCase
  def setup
    @user = users(:user_1)
  end

  test "should redirect unsigned user to ticket creation page" do
    sign_out @user
    get :index
    assert_redirected_to '/tickets/new'
  end

  test "should redirect signed user to tickets list page" do
    sign_in @user
    get :index
    assert_redirected_to '/tickets/index'
  end
end
