class ListingsController < ApplicationController
  before_filter :login_required
  
  def index
    @listings = Listing.find(:all, :conditions => {:user_id => current_user.id}, :order => 'created_at DESC') 
  end
 
  def all_listings
    @listings = Listing.paginate(:all, :page => params[:page], :order => 'updated_at DESC')

  end
 
  def new
    @listing = Listing.new
  end
  
  def applicants
    @applications = Application.find(:all, :conditions => {:listing_id => params[:id]}, :order => 'created_at DESC')
  end
  
  def create
    @listing = Listing.new(params[:listing])
    #@listing[:user_id] = current_user.id  #doing this directly in the form using hidden field
    if @listing.save
      flash[:notice] = 'Listing was successfully created!'
      redirect_to listings_url
    else
      render :action => :new
    end
  end
  
  def show
    @listing = Listing.find(params[:id])
    #@applications = @listing.applications
    @applications = Application.find(:all, :conditions => {:listing_id => params[:id], :user_id => current_user.id}, :order => 'created_at DESC')
    @applicants = @listing.applications
    @comment = @listing.comments.build
    @comments = @listing.comments
    @comments = @comments.paginate(:page => params[:page], :order => 'created_at')
  end
  
  def update
    @listing = Listing.find(params[:id])
    if @listing.update_attributes(params[:listing])
      flash[:notice] = 'Listing was successfully updated.'
      redirect_to(@listing)
    else  
      render :action => "edit"
    end
  end
  
  def destroy
    @listing = Listing.find(params[:id])
    @comments = @listing.comments
    @comments.destroy
    @listing.destroy
    flash[:notice] = 'Listing was deleted!'
    redirect_to listings_url
  end
  
  def search
    query = params[:query]
    @listings = Listing.find_with_sphinx query,:sphinx => {:limit => PER_PAGE, :page => @page}
    @listing_pages = pages_for @listings.total, :page => @page
  end
end
