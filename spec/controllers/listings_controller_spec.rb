require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListingsController  do

  describe "Get to /listings" do 
      before(:each) do
        @current_user = mock_model(User)
        controller.stub!(:current_user).and_return(@current_user)
         
        @listing = mock_model(Listing)
        Listing.stub!(:find).and_return([@listing])
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
        response.should render_template('show')
      end
      
      it "should be successful" do
        get :index
        response.should be_success
      end
      
      it "should find a list of all listings" do
         Listing.should_receive(:find).with(:all, {:conditions => {:user_id => @current_user.id}}).and_return([@listing])
         get :index
      end
      
      it "should assign the found Listing to the view " do
        do_get
        assigns[:listing].should == [@listing]
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
        Listing.stub!(:new).and_return([@listing])
        @params = { :user_id => 1,
                    :title => 'Title',
                    :body => 'Body'
                  } 
        
      end
      
      
      describe "success path" do
      
        it "should create a new listing" do
          @listing.should_receive(:save).and_return(true)
          post :create
        end
        
        it "should redirect to the show template" do
   
        end
        
        it "should populate the flash message" do
        end
        
      end
    
    end

end
