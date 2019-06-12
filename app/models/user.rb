class User < ActiveRecord::Base
  has_many :destinations
end
