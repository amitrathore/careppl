require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do
  before(:each) do
    @valid_attributes = { :user_id => 1,
                          :listing_id => 1,
                          :body => 'A comment!'
                        }
   
  	@comment = Comment.new
    @user1 = User.create(:id => 1, :login => 'quire1', :email => 'quire1@example.com', :password => 'quire', :password_confirmation => 'quire', :account_type => "organization")
  end

  it "should create a new instance given valid attributes" do
    Comment.create(@valid_attributes).should be_valid
  end
  
  it "should have a body which is not null" do
    @comment.should_not be_valid
  end
    
  it "should return true if the user owns the comment" do
		@comment.user_id = 1
  	@comment.owner?(1).should == true	
  end
  
end
