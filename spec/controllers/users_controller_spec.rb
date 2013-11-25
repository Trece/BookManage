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
end
