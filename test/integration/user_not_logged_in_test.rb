require 'test_helper'

class UserNotLoggedInTest < ActionDispatch::IntegrationTest
  
  test "a user that is not logged in can see rewards" do
   
    Reward.create(name: 'reward1', description: 'asdf')
    Reward.create(name: 'reward2', description: 'asdf')
    Reward.create(name: 'reward3', description: 'asdf')

    visit root_path

    assert page.has_content?('Pointbox'), 'title not found'
    assert page.has_content?('reward1'), 'reward1 not found'
    assert page.has_content?('reward2'), 'reward2 not found'
    assert page.has_content?('reward3'), 'reward3 not found'
  end
  
  test "un-authenticated user cannot see a user's dashboard" do

    visit user_path(1)

    assert_equal current_path, root_path
  end

  test "un-authenticated user cannot visit admin pages" do
    visit admin_dashboard_index_path

    assert page.has_content?("The page you were looking for doesn't exist") 
  end

end
