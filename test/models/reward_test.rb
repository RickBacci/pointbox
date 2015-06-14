require 'test_helper'

class RewardTest < ActiveSupport::TestCase
  
  def valid_attributes
    { name: "pizza", description: "deep-dish" }
  end

  test "create a valid reward" do
    reward = Reward.new(valid_attributes)

    assert reward.valid?, 'invalid reward'
  end

  test "reward is invalid without a name" do
    reward = Reward.new(name: nil, description: 'blah')

    assert reward.invalid?, 'reward should not be valid'
  end

  test "reward is invalid without a description" do
    reward = Reward.new(name: 'string', description: nil)

    assert reward.invalid?, 'reward should not be valid'
  end
end

