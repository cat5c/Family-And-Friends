class CitiesController < ApplicationController
	require 'will_paginate/array'
	before_action :set_city, only: [:show]

	def index
		params[:page] = params[:page] || 1
		sorted_cities_arr = City.all.sort_by {|city| city.total_likes }.reverse


		@cities = WillPaginate::Collection.create(params[:page], 12, sorted_cities_arr.length) do |pager|
		  pager.replace sorted_cities_arr[pager.offset, pager.per_page]
		end
	end

	def show
		query = [@city.latitude, @city.longitude]
		@pictures = Picture.near(query, 50).where("created_at >= now()- interval '1 day' ").order(cached_votes_up: :desc).page(params[:page])
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
    	@city = City.find_by(name: params[:id].split("-").map(&:capitalize).join(" ")) || City.find(params[:id])
    end
end
