class User < ApplicationRecord
  validates_presence_of :username
  validates :username, uniqueness: { case_sensitive: false, message: 'This login is already registered. Please, log in.' }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  has_many :projects
  has_secure_password
end
