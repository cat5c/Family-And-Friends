class Comment < ApplicationRecord
	belongs_to :picture; :user
end
