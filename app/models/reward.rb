class Reward < ActiveRecord::Base
  validates :name, :description, presence: true   
end
