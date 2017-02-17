require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
    @user = users :admin
    @other_user = users :tranxuannam
  end

  test "should get new" do
    get signup_path
    assert_response :success
    assert_select "title", "Sign up | #{@base_title}"
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_path
  end

  test "should redirect destroy when logged in user is non-admin" do
    log_in_as @other_user
    assert_no_difference "User.count" do
      delete user_path @user
    end
    assert_redirected_to root_path
  end
end
