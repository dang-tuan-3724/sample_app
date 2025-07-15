require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid information" do
    get signup_path
    before_count = User.count
    post users_path, user: { name: "",
                             email: "user@invalid",
                             password: "foo",
                             password_confirmation: "bar" }
    assert_template "users/new"
  end
end
