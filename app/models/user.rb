class User < ApplicationRecord
  has_many :pictures
  has_many :comments, through: :pictures
  # has_many :comments
  acts_as_voter
  has_secure_password
end
