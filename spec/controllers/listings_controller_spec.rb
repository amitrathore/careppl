require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListingsController  do

  before do
     @current_user = mock_model(User)
     controller.stub!(:current_user).and_return(@current_user)
     @params = {:id => 1, :user_id => @current_user.id, :title => 'Title', :body => 'Body'}
  end

  describe "GET to /listings" do 
      before(:each) do
        post :create, :listing => @params
      end
      
      def do_get
        get :show, :id => :first
      end
   
      it "should render the index template" do
        get :index
        response.should render_template('index')
      end
      
      it "should render the show template" do
        do_get
        #Listing.should_receive(:find).with(:conditions => {:listing_id => params[:id]})
        Listing.find(params[:id]).should be_valid
        response.should render_template('show')
      end
      
      it "should be successful" do
        get :index
        response.should be_success
      end
      
      it "should find a list of all listings" do
         Listing.find(:all, :conditions => {:user_id => @current_user.id}, :order => 'created_at DESC').should_not be_empty 
         get :index
      end
      
      it "should assign the found Listing to the view " do
        do_get
        assigns[:listing].body.should == 'Body'
        assigns[:listing].title.should == 'Title'
      end
      
      it "should find the listing requested" do
        Listing.find(:first).should be_valid
        do_get
      end
  end
  
  describe "POST to /listings" do

      it "should create new listing successfully" do
        Listing.find(:first).should be_nil
        post :create , :listing => @params
        Listing.find(:first).should be_valid
        
      end
        
      it "should pass the params to listing" do
        post :create, :listing => @params
        assigns[:listing].title.should == 'Title'
        assigns[:listing].body.should == 'Body'
      end   
    
      it "should re-render new template on failed save" do      
        post :create, :listing => nil
        response.should render_template(:new)
        flash[:notice].should == nil
      end     
      
      it "should delete the listing" do
        post :create , :listing => @params
        Listing.find(:first).should be_valid
        delete :destroy, :id => :first
        Listing.find(:first).should be_nil
        flash[:notice].should == 'Listing was deleted!'
      end
   
    end

end
