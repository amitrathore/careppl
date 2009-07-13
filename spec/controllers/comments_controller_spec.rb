require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsController do
  before do
    @current_user = mock_model(User)
    controller.stub!(:current_user).and_return(@current_user)
  end
  describe "GET to listings/:id/comment" do
    before do
      @listing = mock_model(Listing)
      controller.stub!(:find).and_return(@listing)
      @comment = mock_model(Comment)
      controller.stub!(:find).and_return(@comment)
    end    

  end

end
