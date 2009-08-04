class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :applications
  has_many :comments
  validates_presence_of :title, :body
  acts_as_solr
  
  
  #def self.listings_of_all_users_except (id)
  #  listings =  self.find(:all, :conditions => [:user_id != id ])
  #end
  
  def self.per_page
    10
  end
    
  def owner?(id)
    return true if(self.user_id == id)
  end
  
end
