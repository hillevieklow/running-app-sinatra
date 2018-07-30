class User < ActiveRecord::Base
  validates_uniqueness_of :username, :email
  has_secure_password
  has_many :runs

   def slug
     self.username.downcase.gsub(" ", "-")
   end

   def self.find_by_slug(slug)
    self.all.find {|user| user.slug == slug}
   end
end
