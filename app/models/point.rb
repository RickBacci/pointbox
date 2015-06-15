class Point < ActiveRecord::Base
  belongs_to :user

  # def self.total_points
  #   @user.points.inject(0) { |sum, point| sum + point.points } 
  # end
end
