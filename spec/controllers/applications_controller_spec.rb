require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationsController do
  before do
      @current_user = mock_model(User)
      controller.stub!(:current_user).and_return(@current_user) 
      @listing = mock_model(Listing)
      controller.stub!(:find).and_return(@listing)
      
  end

  
  def do_get
    get :show, :id => 1
  end
  
  describe "GET to applied listings" do
    before do

      @application = mock_model(Application)
      @params = { :id => 1,
                  :title => 'Title',
                  :body => 'Body'
                }
      controller.stub!(:find).and_return([@application])
      @params = { :id => 1,
                  :user_id => 1,
                  :listing_id => 1
                }
    end
    
    it "should be successful" do
      get :index, :id => 1 
      response.should be_success  
    end
    
    it "should render the index template" do
      get :index
      render_template('index')
    end
    
    it "should render the show template" do
      get :show , :id => 1
      render_template('show')  
    end
    
    it "should find all the applied listings of the user" do
      Application.should_receive(:find).with(:all, :conditions => {:user_id => params[:id]}, :order => 'created_at DESC').and_return([@application]) 
      get :index
    end
  end
  
  describe "POST to applied listings" do
 
    it "should create a valid object" do
      Application.find_by_listing_id_and_user_id("1", @current_user.id).should be_nil
      post :create, :listing_id => 1
      Application.find_by_listing_id_and_user_id("1", @current_user.id).should be_valid
    end
  
  
	  it "should delete the listing when the user wants to unapply" do
  		post :create, :listing_id => 1
  		@application = Application.find_by_listing_id_and_user_id("1", @current_user.id) 
      Application.find_by_id(@application.id).should_not be_nil
  		delete :destroy, :id => @application.id
  		Application.find_by_id(@application.id).should be_nil
		end
		
  end
end
