class ListingsController < ApplicationController
  before_filter :login_required
  
  def index
    @listings = Listing.find(:all, :conditions => {:user_id => current_user.id}, :order => 'created_at DESC') 
    #@listings = Listing.paginate(@listings, :page => params[:page], :order => 'updated_at DESC')
  end
 
  def all_listings
    @listings =  Listing.find(:all) - Listing.find(:all, :conditions => {:user_id => current_user.id}) 
    @listings = Listing.paginate(@listings, :page => params[:page], :order => 'updated_at DESC')
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
    @applications = @listing.applications
    @comment = @listing.comments.new
    @comments = @listing.comments
    @comments = @comments.paginate(:page => params[:page], :order => 'created_at')
  end
  
  def edit
  	@listing = Listing.find(params[:id])
  end
  
  def update
    @listing = Listing.find(params[:id])
    if @listing.update_attributes(params[:listing])
      flash[:notice] = 'Listing watotals successfully updated!'
      redirect_to(@listing)
    else  
      render :action => "edit"
    end
  end
  
  def destroy
    @listing = Listing.find(params[:id])
    @applications = @listing.applications
    @applications.each do |application|
      application.destroy
    end
    @comments = @listing.comments
    @comments.each do |comment|
       comment.destroy
    end
    @listing.destroy
    flash[:notice] = 'Listing was deleted!'
    redirect_to listings_url
  end
  
  def search
    @query = params[:query]
      if !@query.blank?
        #redirect_to listings_url
      #else
        #@listing_results = Listing.find_by_solr(params[:query], :limit => 100)
        #@listings = @listing_results.docs
        @count = Listing.count_by_solr(params[:query])
        @listings = Listing.paginate_all_by_solr(params[:query], :page => params[:page], :total_entries => @count)
        #@listing_pages = pages_for @listing_results.total, :page => @page
        #@listings = Listing.paginate(@listings_results.docs, :page => params[:page], :order => 'updated_at DESC')       
      end    
  end
  
end
