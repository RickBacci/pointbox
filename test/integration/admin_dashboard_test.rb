require 'test_helper'

class AdminDashboardTest < ActionDispatch::IntegrationTest

  test "admin can see admin dashboard" do 

    admin = User.create(name: "admin", password: 'adminpass', role: 1)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_index_path

    assert page.has_content?("Admin Dashboard"), 'Admin login unsuccessful'
  end

  test "regular user cannnot visit admin dashboard" do

    user = User.create(name: 'user', password: 'pass', role: 0)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_dashboard_index_path

    refute page.has_content?("Admin Dashboard"), 'User can see admin page'
    assert page.has_content?("The page you were looking for doesn't exist."),
                             "404 page not shown"
  end

  test "admin can add a reward" do
    admin = User.create(name: "admin", password: 'adminpass', role: 1)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_index_path

    click_button "Add new reward"

    fill_in "Name", with: "Pizza"
    fill_in "Description", with: "Yummy!"

    click_button "Create Reward"

    assert page.has_content?("Pizza"), "reward name empty"
    assert page.has_content?("Yummy!"), "reward description empty"
  end
 
  test "non-admin cannot add rewards" do 
    
    user = User.create(name: "user", password: 'userpass', role: 0)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit new_reward_path

    assert page.has_content?("The page you were looking for doesn't exist") 
  end

  test "admin can delete a reward" do
    admin = User.create(name: 'admin', password: 'adminpass', role: 1)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    reward = Reward.create(name: 'none', description: 'about to die')

    visit root_path
    assert page.has_content?('none'), 'missing reward name'

    visit reward_path(reward)
    click_button "Delete Reward"

    refute page.has_content?('none'), 'reward not deleted'
  end

  test "admin can edit a reward" do
    
    admin = User.create(name: 'admin', password: 'adminpass', role: 1)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    reward = Reward.create(name: 'none', description: 'about to die')
    
    visit edit_reward_path(reward)

    fill_in "Name", with: "some"
    fill_in "Description", with: "thing new"

    click_button "Update Reward"

    assert page.has_content?("some"), 'Failure message.'
    refute page.has_content?("none"), 'Failure message.'
  end


#  as an admin
# when i visit the list of users
# and click on a user
# and select a point value
# and click 'assign points'
# it should assign those points to the user

  test "something interesting" do
    admin = User.create(name: 'admin', password: 'adminpass', role: 1)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    
    visit users_path
    click_link "admin"
    
    assert_equal 0, admin.points
    check "100"

    click_button "Assign points"

    assert_equal 100, admin.points
  end
end
