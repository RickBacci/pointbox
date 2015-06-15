class User < ActiveRecord::Base
  has_secure_password
  has_many :rewards
  has_many :points

  validates :name, presence: true,
                   uniqueness: true

  enum role: %w(default admin)
end
