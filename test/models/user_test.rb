require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def valid_attributes
    { name: "Aerith Gainsborough", password: "none" }
  end

  def invalid_attributes
    { name: nil, password: nil }
  end


  test "create a valid user" do
    user = User.new(valid_attributes)

    assert user.valid?, 'invalid user.'
  end

  test "user is invalid without a name" do
    user = User.new(invalid_attributes)
    
    refute user.valid?
  end

  test "user name must be unique" do
    2.times { User.create(valid_attributes) }

    users = User.where(name: "Aerith Gainsborough")
    
    assert_equal 1, users.count
  end

  test "user can have many rewards" do
    user = User.create(valid_attributes)
    assert_equal user.rewards, []
  end
end
