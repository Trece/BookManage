require 'spec_helper'

describe UsersController do

  let(:valid_attributes) { { "jobid" => "MyString" } }
  let(:valid_session) { {} }

  describe "index" do
    before(:each) do
      @user = FactoryGirl.build(:user)
      @reader = FactoryGirl.build(:reader)
      @url = "http://127.0.0.1/"
      @jobid = "1234"
      @name = "Wa"
      @email = "tre@gmail.com"
      @ticket = "abcdefhijk"
      @request.stub(:remote_ip).and_return("1.1.1.1")
      User.stub(:ticket_url).and_return(@url)
    end

    it "should look for user by jobid" do
      User.should_receive(:find_by_jobid).with(@jobid)
      Net::HTTP.stub(:get).and_return("zjh=#{@jobid}:xm=#{@name}:email=#{@email}")
      get :index, ticket: @ticket
    end

    it "should get from the right url" do
      Net::HTTP.should_receive(:get).with(URI.parse('http://127.0.0.1/abcdefhijk/1_1_1_1')).and_return('')
      get :index, ticket: @ticket
    end
    
    it "should fail if the verifier fail" do
      Net::HTTP.stub(:get).and_return('')
      User.stub(:find_by_jobid).and_return(@user)
      get :index, ticket: @ticket
      response.should redirect_to home_path
      session[:user_id].should == nil
    end

    it "should create the user and reader when successed and not exist" do
      Net::HTTP.stub(:get).and_return("zjh=#{@jobid}:xm=#{@name}:email=#{@email}")
      User.stub(:find_by_jobid).and_return(nil)
      User.should_receive(:create).with(jobid: @jobid, name: @name).and_return(@user)
      @user.stub(:reader).and_return(nil)
      Reader.should_receive(:create).with(name: @name, email: @email, user: @user)
      get :index, ticket: @ticket
    end

    it "should find the user and update the information" do
      Net::HTTP.stub(:get).and_return("zjh=#{@jobid}:xm=#{@name}:email=#{@email}")
      User.stub(:find_by_jobid).and_return(@user)
      @user.should_receive(:update_attributes).with(name: @name)
      @user.stub(:reader).and_return(@reader)
      @reader.should_receive(:update_attributes).with(name: @name)
      get :index, ticket: @ticket
    end
  end

  describe "logout" do
    it "should clear the session" do
      session[:user_id] = "1"
      get :logout, id: "1"
      session[:user_id].should == nil
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show, {:id => user.to_param}, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new, {}, valid_session
      assigns(:user).should be_a_new(User)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :edit, {:id => user.to_param}, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}, valid_session
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the created user" do
        post :create, {:user => valid_attributes}, valid_session
        response.should redirect_to(User.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => { "jobid" => "invalid value" }}, valid_session
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => { "jobid" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        user = User.create! valid_attributes
        # Assuming there are no other users in the database, this
        # specifies that the User created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        User.any_instance.should_receive(:update_attributes).with({ "jobid" => "MyString" })
        put :update, {:id => user.to_param, :user => { "jobid" => "MyString" }}, valid_session
      end

      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        assigns(:user).should eq(user)
      end

      it "redirects to the user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        response.should redirect_to(user)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        user = User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => { "jobid" => "invalid value" }}, valid_session
        assigns(:user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        user = User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => { "jobid" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, {:id => user.to_param}, valid_session
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = User.create! valid_attributes
      delete :destroy, {:id => user.to_param}, valid_session
      response.should redirect_to(users_url)
    end
  end

end
