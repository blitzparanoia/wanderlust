class User < ActiveRecord::Base
  has_many :destinations

  has_secure_password

  # def slug
  #    self.username.downcase.gsub(/[^0-9a-z\- ]/, "").gsub(" ", "-")
  #  end
  #
  #  def self.find_by_slug(name)
  #    user = User.find {|user| user.slug == name}
  #  end
end
