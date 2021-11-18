class User < ApplicationRecord
    has_secure_password
    has_many :posts

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: /@/
  validates :password, presence: true

end
