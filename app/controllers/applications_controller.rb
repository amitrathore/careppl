class ApplicationsController < ApplicationController
  
  def index
    @applications = Application.find(:all,:conditions => {:user_id => params[:id]}, :order => 'created_at DESC')
    @applications = @applications.paginate(:page => params[:page], :order => 'created_at DESC')
    render :layout => false
  end
  
  def new
    @application = Application.new
  end
  
  def create
    @application = Application.new
    @application[:listing_id]= params[:listing_id]
    @application[:user_id] = current_user.id
    if Application.exists(params[:listing_id], current_user.id)
      flash[:notice] = "Already applied to this Listing!"
      redirect_to applications_url(:id => current_user.id)
    elsif @application.save
      flash[:notice] = "Successfully applied to the Listing!"
      redirect_to applications_url(:id => current_user.id)
    else
      render :action => :new
    end
  end
  
  def destroy
    @application = Application.find(params[:id])
    @application.destroy
    redirect_to applications_url(:id => current_user.id)
  end
  
end

