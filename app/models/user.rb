class User < ApplicationRecord
  has_many :pictures; :comments
  acts_as_voter
end
