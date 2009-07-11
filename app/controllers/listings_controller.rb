class ListingsController < ApplicationController
  before_filter :login_required
  
  def index
    @listings = Listing.find(:all, :conditions => {:user_id => current_user.id}, :order => 'created_at DESC') 
  end
 
  def all_listings
    @listings = Listing.find(:all)
  end
 
  def new
    @listing = Listing.new
  end
  
  def applicants
    @applications = Application.find(:all, :conditions => {:listing_id => params[:id]})
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
    @applications = Application.find(:all, :conditions => {:listing_id => params[:id], :user_id => current_user.id})
    @applicants = @listing.applicants
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
end
