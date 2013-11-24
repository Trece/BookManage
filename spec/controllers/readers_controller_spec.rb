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

  describe "GET edit" do
    it "assigns the requested reader as @reader" do
      reader = Reader.create! valid_attributes
      get :edit, {:id => reader.to_param}, valid_session
      assigns(:reader).should eq(reader)
    end
  end


  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested reader" do
        reader = Reader.create! valid_attributes
        # Assuming there are no other readers in the database, this
        # specifies that the Reader created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Reader.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => reader.to_param, :reader => { "these" => "params" }}, valid_session
      end

      it "assigns the requested reader as @reader" do
        reader = Reader.create! valid_attributes
        put :update, {:id => reader.to_param, :reader => valid_attributes}, valid_session
        assigns(:reader).should eq(reader)
      end

      it "redirects to the reader" do
        reader = Reader.create! valid_attributes
        put :update, {:id => reader.to_param, :reader => valid_attributes}, valid_session
        response.should redirect_to(reader)
      end
    end

    describe "with invalid params" do
      it "assigns the reader as @reader" do
        reader = Reader.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Reader.any_instance.stub(:save).and_return(false)
        put :update, {:id => reader.to_param, :reader => {  }}, valid_session
        assigns(:reader).should eq(reader)
      end

      it "re-renders the 'edit' template" do
        reader = Reader.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Reader.any_instance.stub(:save).and_return(false)
        put :update, {:id => reader.to_param, :reader => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

end
