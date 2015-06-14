class User < ActiveRecord::Base
  has_secure_password
  has_many :rewards

  validates :name, presence: true,
                   uniqueness: true

  enum role: %w(default admin)
end
