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
    @comment = @listing.comments.create!(params[:comment])
    @current_user_id = current_user.id
    flash[:notice] = 'Created Comment!'
    respond_to do |format|
      format.html {redirect_to @listing}
      format.js { render 'comments/create.js.rjs' }
    end
      
    
  end
  
  def destroy
    @listing = Listing.find(params[:listing_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = 'Deleted Comment!'
    respond_to do |format|
      format.html {redirect_to @listing}
      format.js { render :nothing => true }
    end  
  end
  
end

