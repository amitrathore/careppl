class AppliedListingsController < ApplicationController
  before_filter :login_required
  def index
    @applied_listings = AppliedListing.find(:all)
  end
    
end
