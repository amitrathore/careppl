require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AppliedListing do
  before(:each) do
    @valid_attributes = { :listing_id => 1, :user_id => 1 }    
  end

  it "should create a new instance given valid attributes" do
    AppliedListing.create!(@valid_attributes)
  end
  

end
