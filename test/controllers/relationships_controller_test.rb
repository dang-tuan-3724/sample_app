require "test_helper"

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect create when not logged in" do
    post relationships_path, params: { followed_id: users(:tuan).id }
    assert_redirected_to login_url
  end
  test "should redirect destroy when not logged in" do
    delete relationship_path(id: relationships(:one))
    assert_redirected_to login_url
  end
end
