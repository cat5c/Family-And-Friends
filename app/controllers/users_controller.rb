class UsersController < ApplicationController

  def index
    @users = User.all.sort_by {|user| user.total_likes }.reverse
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
  end
  
  def create
    p user_params
  	user = User.new(user_params)
    user.save
    session[:user_id] = user.id
    redirect_to '/'
  end

  private

  def user_params
  	params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
end
