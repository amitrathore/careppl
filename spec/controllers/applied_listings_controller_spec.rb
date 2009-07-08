require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AppliedListingsController do
  
  before do
    @current_user = mock_model(User)
    controller.stub!(:current_user).and_return(@user)
    @applied_listing = mock_model(AppliedListing, :id => 1,
                                                  :user_id => 1,
                                                  :title => 'Title',
                                                  :body => 'Body',
                                                  :created_at => Time.now,
                                                  :updated_at => Time.now
                                                  )
    AppliedListing.stub!(:find).and_return([@applied_listing])
    
  end
  
  def do_get
    get :show, :id => 1
  end
  
  it "should be successful" do
    get :index 
    response.should be_success  
  end

end
