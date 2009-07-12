class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :applications
  has_many :comments
  validates_presence_of :title, :body
  
  #def self.listings_of_all_users_except (id)
  #  listings =  self.find(:all, :conditions => [:user_id != id ])
  #end
  
  #def self.display
  #  listings = find(:all)
  #end 
  
  def applicants
    return Application.find(:all, :conditions => {:listing_id => self[:id] })
  end
end
