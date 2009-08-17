class ListingsController < ApplicationController
  before_filter :login_required
  
  def index
    @listings = Listing.find(:all, :conditions => {:user_id => current_user.id}, :order => 'created_at DESC') 
    #@listings = current_user.listings
    @listings = @listings.paginate(:page => params[:page], :per_page => 10, :order => 'updated_at DESC')

  end
 
  def all_listings
    @listings =  Listing.find(:all) - Listing.find(:all, :conditions => {:user_id => current_user.id}) 
    @listings = Listing.paginate(@listings, :page => params[:page],:per_page => 10, :order => 'updated_at DESC')
    render :layout => false
  end
 
  def new
    @listing = Listing.new
    render :layout => false
  end
  
  def create
    @listing = Listing.new(params[:listing])
    if @listing.save
      @listings = current_user.listings
      @listings = @listings.paginate(:page => params[:page], :order => 'updated_at DESC') 
      flash[:notice] = 'Listing was successfully created!'
      respond_to do |format|
        format.html { redirect_to listings_url }
        format.js
      end
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
      flash[:notice] = 'Listing was successfully updated!'
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
    @listings = Listing.find(:all, :conditions => {:user_id => current_user.id}, :order => 'created_at DESC')
    @listings = @listings.paginate(:page => params[:page], :per_page => 10, :order => 'updated_at DESC')
    flash[:notice] = 'Listing was deleted!'
    respond_to do |format|
      format.html { redirect_to listings_url }
      format.js { render 'destroy.js.rjs' }
    end
    
  end
  
  def search
    @query = params[:query]
      if @query.blank?
        redirect_to listings_url
      else
        @count = Listing.count_by_solr(params[:query])
        @listings = Listing.paginate_all_by_solr(params[:query], :page => params[:page], :total_entries => @count)
      end    
  end
  
end

