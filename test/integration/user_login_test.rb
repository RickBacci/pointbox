require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

  test "that a registered user can login" do

    user = User.create(name: 'joe', password: 'smo')
    
    visit login_path

    fill_in "Name", with: 'joe'
    fill_in "Password", with: 'smo'
    
    click_button "Login"

    assert page.has_content?("Welcome, joe"), 'cannot login'

  end

end
