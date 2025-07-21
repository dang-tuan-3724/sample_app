require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tuan)
  end

  test 'successful edit with friendly forwarding' do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user) #friendly forwarding core
    patch user_path(@user),
          params: {
            user: {
              name: 'Dang_Tuan',
              email: 'tuan15cm@example.com',
              password: '',
              password_confirmation: '',
            },
          }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_equal 'Dang_Tuan', @user.name
    assert_equal 'tuan15cm@example.com', @user.email
  end

  test 'unsuccessful edit' do
        get edit_user_path(@user)
        log_in_as(@user)
    patch user_path(@user),
          params: {
            user: {
              name: '',
              email: 'vsv@invalid',
              password: 'foo',
              password_confirmation: 'bar',
            },
          }
    assert_template 'users/edit'
  end
end
