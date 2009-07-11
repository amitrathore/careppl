class Application < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  
  def self.exists(listing_id,current_user_id)
    @applications = find(:all, :conditions => {:listing_id => listing_id, :user_id => current_user_id})   
    return true if(@applications.count > 0)
  end
end