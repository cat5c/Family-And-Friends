class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :set_city, only: [:new, :create]
  before_action :authorize, only: [:show]

  # GET /pictures
  # GET /pictures.json
  def index
    current_location = Geocoder.search("#{location.latitude}, #{location.longitude}").first
    query = "#{current_location.city}, #{current_location.state}"
    @pictures = Picture.near(query, 50).where("created_at >= now()- interval '1 day' ").order(cached_votes_up: :desc).page(params[:page])
  end

  def all
    @pictures = Picture.all.order(cached_votes_up: :desc).page(params[:page])
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @location = Geocoder.search("#{@picture.latitude}, #{@picture.longitude}").first
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  def like
    @picture = Picture.find(params[:id])
    @picture.liked_by current_user
    redirect_back(fallback_location: root_path)
  end

  def unlike
    @picture = Picture.find(params[:id])
    @picture.unliked_by current_user
    redirect_back(fallback_location: root_path)
  end

  # POST /pictures
  # POST /pictures.json
  def create
    # byebug
    @picture = @city.pictures.create(picture_params)
    @picture.latitude = location.latitude
    @picture.longitude = location.longitude
    # p @picture.latitude, @picture.longitude
    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      # geo_location = Geocoder.search("#{location.latitude}, #{location.longitude}").first
      # city = City.find_by(name: geo_location.city) || City.create(name: geo_location.city)
      # params[:city_id] = city.id
      params.require(:picture).permit(:title, :image, :user_id, :city_id)
    end

    def set_city
      geo_location = Geocoder.search("#{location.latitude}, #{location.longitude}").first
      @city = City.find_by(name: geo_location.city) || City.create(name: geo_location.city)
    end
end
