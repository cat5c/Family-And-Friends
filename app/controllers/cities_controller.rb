class CitiesController < ApplicationController
	before_action :set_city, only: [:show]

	def index
    @cities = City.all.sort_by {|city| city.total_likes }.reverse
	end

	def show
		query = [@city.latitude, @city.longitude]
		@pictures = Picture.near(query, 50).order(cached_votes_up: :desc)
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
    	@city = City.find_by(name: params[:id].split("-").map(&:capitalize).join(" ")) || City.find(params[:id])
    end
end
