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
    
    click_button "Create reward"

    assert page.has_content?("Pizza"), "reward name empty"
    assert page.has_content?("Yummy!"), "reward description empty"
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
    click_button "Edit reward"

    fill_in "Name", with: "some"
    fill_in "Description", with: "thing new"

    click_button "Submit"

    assert page.has_content?("some"), 'Failure message.'
    assert page.has_content?("thing new"), 'Failure message.'
    
    refute page.has_content?("none"), 'Failure message.'
  end
end
