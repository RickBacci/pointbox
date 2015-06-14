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



# as an admin
# when i visit the admin panel
# and click on 'add reward'
# and enter the reward name
# and enter the reward description
# and click 'enter'
# it should add the reward to the database



  test "admin can add a reward" do
    admin = User.create(name: "admin", password: 'adminpass', role: 1)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
     byebug
    visit admin_dashboard_index_path
    click_button "Add new reward"

    fill_in "Name", with: "pizza"
    fill_in "Description", with: "Yummy!"
    
    click_button "Create reward"

    assert page.has_content?("Pizza"), "reward name empty"
    assert page.has_content?("Yummy!"), "reward description empty"
  end
end
