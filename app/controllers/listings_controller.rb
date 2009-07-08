class ListingsController < ApplicationController
  before_filter :login_required
  
  def index
    @listings = Listing.find(:all, :conditions =>  {:user_id => current_user.id}) 
  end
 
  def all_listings
    
    @listings = Listing.find(:all)
    #@listings = @all_listings.collect{ |l| l[:user_id]!=current_user.id}
    #@listings.reject{ |l| l.user_id==current_user.id?}
    #@landscapes = @images.collect{ |i| i.portrait != 1}
    @listings.reject{|l| l.user_id== current_user.id}


  end
 
  def new
    @listing = Listing.new
  end
  
  def create
    @listing = Listing.new(params[:listing])
    #@listing[:user_id] = current_user.id  --doing this directly in the form using hidden field
    if @listing.save
      flash[:notice] = 'Listing was successfully created!'
      redirect_to listings_url
    else
      render :action => :new
    end
  end
  
  def show
    @listing = Listing.find(params[:id])
  end  
end
