class User < ApplicationRecord
  has_many :pictures, :comments 
end
