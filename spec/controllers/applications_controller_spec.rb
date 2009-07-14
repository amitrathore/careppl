require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationsController do


  
  def do_get
    get :show, :id => 1
  end
  
  describe "GET to applied listings" do
    before do
      @current_user = mock_model(User)
      controller.stub!(:current_user).and_return(@current_user)
      @listing = mock_model(Listing)
      controller.stub!(:find).and_return([@listing])
       @params = { :id => 1,
                   :title => 'Title',
                   :body => 'Body'
                    }
      @application = mock_model(Application)
      controller.stub!(:find).and_return([@application])
              @params = { :id => 1,
                          :user_id => 1,
                          :listing_id => 1
                    }
      
    end
    
    it "should be successful" do
      get :index 
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
    
    before do
      @current_user = mock_model(User)
      controller.stub!(:current_user).and_return(@current_user)
      @application = mock_model(Application)
      controller.stub!(:new).and_return(@application)
      @listing = mock_model(Listing)
      controller.stub!(:find).and_return(@listing)
    end
      
    it "should save a valid object" do
      @application.should_receive(:save).and_return(true)
      Application.should_receive(:new).and_return(true)
      #@listing.Application.should_receive(:create).and_return(@application)
      post :create  
    end
  end
end
