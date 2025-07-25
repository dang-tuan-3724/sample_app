require "test_helper"

class FollowingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tuan)
    @other_user = users(:user_test)
    log_in_as(@user)
  end
end
class FollowingPagesTest < FollowingTest
    test "following page" do
    get following_user_path(@user)
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end
end

class FollowTest < FollowingTest
  test "should follow a user the standard way" do
    assert_difference "Relationship.count", 1 do
      post relationships_path, params: { followed_id: @other_user.id }
    end
  end
  test "should follow a user the hotwire way" do
    assert_difference "Relationship.count", 1 do
      post relationships_path(format: :turbo_stream), params: { followed_id: @other_user.id }
    end
  end
end
class UnFollow < FollowingTest
  def setup
    super
    @user.follow(@other_user)
    @relationship = @user.active_relationships.find_by(followed_id: @other_user.id)
  end
end
class UnFollowTest < UnFollow
  test "should unfollow a user the standard way" do
    assert_difference "Relationship.count", -1 do
      delete relationship_path(relationships(:one))
    end
  end
  test "should unfollow a user the hotwire way" do
    assert_difference "Relationship.count", -1 do
      delete relationship_path(relationships(:one), format: :turbo_stream)
    end
  end
end

