require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListingsController  do

  describe "GET to /listings" do 
      before(:each) do
        @current_user = mock_model(User)
        controller.stub!(:current_user).and_return(@current_user)
        @applications = mock_model(Application)
        @comments = mock_model(Comment) 
        @comment = mock_model(Comment)
        @listing = mock_model(Listing)
        @listing.stub!(:applications).and_return(@applications)
        @listing.stub!(:comments).and_return(@comments)
        @comments.stub!(:new).and_return(@comments)
        Listing.stub!(:find).and_return(@listing)
        @comments.stub!(:paginate).with(:page => nil, :order => 'created_at').and_return(@comments)
        @params = { :id => 1,
                    :user_id => 1,
                    :title => 'Title',
                    :body => 'Body'
                  }
      end
      
      def do_get
        get :show, :id => 1
      end
   
      it "should render the index template" do
        get :index
        response.should render_template('index')
      end
      
      it "should render the show template" do
        do_get
        #Listing.should_receive(:find).with(:conditions => {:listing_id => params[:id]})
        response.should render_template('show')
      end
      
      it "should be successful" do
        get :index
        response.should be_success
      end
      
      it "should find a list of all listings" do
         Listing.should_receive(:find).with(:all, :conditions => {:user_id => @current_user.id}, :order => 'created_at DESC').and_return([@listing])
         get :index
      end
      
      it "should assign the found Listing to the view " do
        do_get
        assigns[:listing].should == @listing
      end
      
      it "should find the listing requested" do
        Listing.should_receive(:find).with("1").and_return(@listing)
        do_get
      end
  end
  
  describe "POST to /listings" do
      before(:each) do
        @current_user = mock_model(User)
        controller.stub!(:current_user).and_return(@current_user)
         
        @listing = mock_model(Listing)
        controller.stub!(:new).and_return(@listing)
      end
      
        
      it "should create new listing successfully" do
        @listing.should_receive(:save).and_return(true)
        Listing.should_receive(:new).with(anything()).and_return(@listing)
        post :create
        response.should redirect_to(listings_url) 
        flash[:notice].should == 'Listing was successfully created!'
      end
        
      it "should pass the params to listing" do
        post 'create', :listing => {:title => 'Title'}
        assigns[:listing].title.should == 'Title'   
      end   
    
      it "should re-render new template on failed save" do      
        @listing.should_receive(:save).and_return(false)
        Listing.should_receive(:new).with(anything()).and_return(@listing)
        post :create
        response.should render_template(:new)
        flash[:notice].should == nil
      end     
   
    end

end
