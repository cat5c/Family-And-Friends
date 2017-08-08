class City < ApplicationRecord
	has_many :pictures
	geocoded_by :name
	after_validation :geocode

  def total_likes
  	self.pictures.sum(:cached_votes_up)
  end

end
