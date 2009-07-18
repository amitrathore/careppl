require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsController do # Commented out the mock models.
  before do
    @current_user = mock_model(User)
    controller.stub!(:current_user).and_return(@current_user)
    #@comment = mock_model(Comment)
    #@listing = mock_model(Listing)
    #@listing.stub!(:comments).and_return(@comment) 
    #Listing.stub!(:find).and_return(@listing)
  end
  describe "GET to listings/:id/comment" do   

    it "should render the listing page to which the comment belongs" do
      #controller.stub!(:find).and_return(@comment)
      #get :index, :listing => @listing
    end
  end
  
  describe "POST to listings/:id/comment" do
    
    before do
      @valid_attributes = {:user_id => @current_user.id, :title => 'title', :body => 'body'}
      @listing = Listing.create(@valid_attributes)
    end
  
    it "should create a new comment" do
      Comment.find_by_listing_id(@listing.id.to_s).should be_nil
      post :create, :listing_id => @listing.id, :id => 1
      Comment.find_by_listing_id(@listing.id.to_s).should_not be_nil #getting error here!
  
    end
    
    it "should delete a comment when destroying one" do
      
      #Comment.stub!(:find).and_return(@comment)
      #@comment.should_receive(:destroy).once
      #delete :destroy, :id => 1
    end
   
    
  end
end
