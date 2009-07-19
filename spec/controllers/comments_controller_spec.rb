require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsController do # Commented out the mock models.
  before do
    @current_user = mock_model(User)
    controller.stub!(:current_user).and_return(@current_user)
    @valid_attributes = {:id => 1, :user_id => @current_user.id, :title => 'title', :body => 'body'}
    @listing = Listing.create(@valid_attributes)
  
  end
  describe "GET to listings/:id/comment" do   
    before do
      @comment = Comment.create!(:listing_id => @listing.id, :user_id => @current_user.id, :body => 'body')

    end
  
    it "should render the listing page to which the comment belongs" do
      @listing_find = Listing.find(@comment.listing_id)
      get :index, :listing_id => @listing_find.id 
    end
    
  end
  
  describe "POST to listings/:id/comment" do
    
    
  
    it "should create a new comment" do
      Comment.find_by_listing_id(@listing.id.to_s).should be_nil
      post :create, :listing_id => @listing.id, :comment => {:body => 'body', :user_id => @current_user.id}
      Comment.find_by_listing_id(@listing.id.to_s).should be_valid
    end
    
    it "should delete a comment when destroying one" do
      @comment = Comment.create(:listing_id => @listing.id, :user_id => @current_user.id, :body => 'body')
      Comment.find_by_listing_id(@listing.id.to_s).should be_valid
      delete :destroy, :listing_id => @listing.id, :id => @comment.id
      Comment.find_by_listing_id(@listing.id.to_s).should be_nil
    end
  end
end
