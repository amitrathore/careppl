require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsController do
  before do
    @current_user = mock_model(User)
    controller.stub!(:current_user).and_return(@current_user)
    @comment = mock_model(Comment)
    @listing = mock_model(Listing)
    @listing.stub!(:comments).and_return(@comment) 
    Listing.stub!(:find).and_return(@listing)
  end
  describe "GET to listings/:id/comment" do   

    it "should render the listing page to which the comment belongs" do
      controller.stub!(:find).and_return(@comment)
      get :index, :listing => @listing
    end
  end
  
  describe "POST to listings/:id/comment" do
    
    it "should create a new comment" do
      @comment.should_receive(:save).and_return(true)
      @comment.should_receive(:new).with(anything()).and_return(@comment)
      post :create
    end
    
    it "should delete a comment when destroying one" do
      Comment.stub!(:find).and_return(@comment)
      @comment.should_receive(:destroy).once
      delete :destroy, id => 1
    end
    
  end
end
