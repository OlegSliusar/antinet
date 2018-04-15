require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:oleh)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path, count: 2
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", edit_user_path(@user), count: 0
    get signup_path
    assert_select "title", full_title("Sign up")
    log_in_as(@user)
    follow_redirect!
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
  end
end
