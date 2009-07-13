class Comment < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user
  validates_presence_of  :body
  
  def owner?(current_user_id)
    return true if(self.user_id == current_user_id)
  end
  
  def self.per_page
    10
  end
end
