require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin         = users(:oleh)
    @non_admin     = users(:archer)
    @not_activated = users(:lana)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      # Don't show in list unactivated users
      if user == @not_activated
        assert_select 'a[href=?]', user_path(user), count: 0
      else
        assert_select 'a[href=?]', user_path(user), text: user.name
      end
      # Don't select 'delete' link for unactivated users
      unless user == @admin || user == @not_activated
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "show unactivated user and redirecting to root" do
    log_in_as(@admin)
    get user_path(@not_activated)
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
