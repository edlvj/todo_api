class User < ApplicationRecord
  validates_presence_of :username
  validates :username, uniqueness: true

  has_many :projects
  has_secure_password
end
