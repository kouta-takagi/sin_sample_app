require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup infomation" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "", email: "user@invalid", password: "foo", password_confirmatiion: "bar" }}
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end

  test "valid signup infomation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "kouta", email: "a@example.com", password: "kakaka", password_confirmatiion: "kakaka" }}
    end
    follow_redirect!
    # assert_template 'users/show'
    # assert is_logged_in?
  end
end
