require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Listing do
  before(:each) do
    @valid_attributes = {:id => 1, :user_id => 1, :title => "Listing Name", :body => "A nice new Listing"}
    @listing = Listing.create(@valid_attributes)
    @user1 = User.create(:id => 1, :login => 'quire1', :email => 'quire1@example.com', :password => 'quire', :password_confirmation => 'quire', :account_type => "organization")
    @user2 = User.create(:id => 2,:login => 'quire2', :email => 'quire2@example.com', :password => 'quire', :password_confirmation => 'quire', :account_type => "individual")
  end

  it "should create a new instance given valid attributes" do
    Listing.create(@valid_attributes).should be_valid
  end
    
  it "should have a valid user id of type organisation" do
   # params = {:controller => '/login'}
   # @user_of_listing = User.find(params[:id => @listing.user_id])
   # @user_of_listing.account_type.sh  ould == "organization"
  end

  
  it "should have a title which is not null" do
    @listing_test = Listing.create(:id => 1, :user_id => 1, :title => "", :body => "A nice new Listing")
    @listing_test.should_not be_valid
  end
  
  it "should have a description which is not null" do
    @listing_test = Listing.create(:id => 1, :user_id => 1, :title => "Listing Name", :body => "")
    @listing_test.should_not be_valid
  end
end
