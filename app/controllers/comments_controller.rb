class CommentsController < ApplicationController

	  http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

  def create
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.create(comment_params)
    @user = User.find(@comment.user_id)
    redirect_to picture_path(@picture)
  end
 
  def destroy
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.find(params[:id])
    @comment.destroy
    redirect_to picture_path(@picture)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:picture_id, :user_id, :body)
    end

end
