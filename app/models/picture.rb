class Picture < ApplicationRecord
  belongs_to :user; :city
  has_many :comments, dependent: :destroy
  acts_as_votable
  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment :image, :presence => true, :size => { :in => 0..1000.kilobytes }, content_type: {content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]}
  reverse_geocoded_by :latitude, :longitude
	self.per_page = 12
end
