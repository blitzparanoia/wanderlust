class User < ActiveRecord::Base
  has_many :destinations

  has_secure_password

  validates :username, presence: true
  
end
