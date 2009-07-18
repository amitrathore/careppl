class CommentsController < ApplicationController
  def index
    @listing = Listing.find(params[:listing_id])
    @comments = @listing.comments
  end
  
  def new
    @listing = Listing.find(params[:listing_id])
    @comment = @listing.comments.new
  end
  
  def create
    @listing = Listing.find(params[:listing_id])
    @comment = @listing.comments.new(params[:comment])
    @current_user_id = current_user.id
    if(@comment.save)
      flash[:notice] = 'Created Comment!'
      redirect_to listing_url(@listing)
    else
      redirect_to listing_url(@listing)
    end
  end
  
  def destroy
    @listing = Listing.find(params[:listing_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = 'Comment was deleted!'
    redirect_to listing_url(@listing)
  end
end
