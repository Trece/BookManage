require 'spec_helper'

describe ReadersController do

  let(:valid_attributes) { {  } }
  let(:valid_session) { {} }
  
  describe "index" do
    before(:each) do 
      @user = FactoryGirl.build(:user)
      @reader = FactoryGirl.build(:reader)
    end
    it "should accept super" do
      User.stub(:find).and_return(@user)
      @user.stub(:is_admin?).and_return(true)
      ReadersController.stub(:current_user).and_return(@user)
      Reader.should_receive(:all).and_return([@reader])
      session[:user_id] = "1"
      get :index
      assigns(:readers).should == [@reader]
    end
    it "should forbid all other reader" do
      User.stub(:find).and_return(@user)
      @user.stub(:is_admin?).and_return(false)
      session[:user_id] = "1"
      get :index
      response.should redirect_to home_path
      flash[:notice].should == "Permission denied"
    end
  end

  describe "show" do
    before(:each) do 
      @user = FactoryGirl.build(:user)
      @reader = FactoryGirl.build(:reader)
    end

    it "assigns the requested reader as @reader when user is valid" do
      session[:user_id] = "1"
      User.stub(:find).and_return(@user)
      @user.stub(:reader).and_return(@reader)
      get :show, id: @reader.id
      assigns[:reader].should == @reader
    end

    it "redirect when reader isn't valid" do
      get :show, id: @reader.id
      response.should redirect_to home_path
      flash[:notice].should == "Permission denied"
    end
  end

  describe "edit" do
    before(:each) do
      @user = FactoryGirl.build(:user)
      @reader = FactoryGirl.build(:reader)
      session[:user_id] = "1"
    end
    it "calls the filter" do
      controller.should_receive(:auth_reader).and_return(true)
      controller.stub(:current_reader).and_return(@reader)
      get :edit, id: @reader.id
    end
    it "assigns the requested reader as @reader" do
      User.stub(:find).and_return(@user)
      @user.stub(:reader).and_return(@reader)
      get :edit, id: @reader.id
      assigns[:reader].should == @reader
    end
  end


  describe "update" do
    before(:each) do
      @user = FactoryGirl.build(:user)
      @reader = FactoryGirl.build(:reader)
      session[:user_id] = "1"
    end
    it "calls the filter" do
      controller.should_receive(:auth_reader).and_return(true)
      controller.stub(:current_reader).and_return(@reader)
      get :edit, id: @reader.id
    end
    it "calls the update the database correctly" do
      dict = {"email" => "ss@gmail.com"}
      controller.stub(:auth_reader).and_return(true)
      controller.stub(:current_reader).and_return(@reader)
      @reader.should_receive(:update_attributes).with(dict).and_return(true)
      put :update, reader: dict, id: @reader.id
    end
    it "redirect with error correctly when invalid" do
      dict = {"email" => "ss@gmail.com"}
      controller.stub(:auth_reader).and_return(true)
      controller.stub(:current_reader).and_return(@reader)
      @reader.stub(:update_attributes).with(dict).and_return(false)
      put :update, reader: dict, id: @reader.id
      response.should render_template "edit"
    end
  end

end
