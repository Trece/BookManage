require 'spec_helper'

describe ReadersController do

  let(:valid_attributes) { {  } }
  let(:valid_session) { {} }
  
  describe "index" do
    before(:each) do 
      @user = FactoryGirl.build(:user)
      @reader = FactoryGirl.build(:reader)
    end
    it "should forbid visit except super" do
      @user.stub(:is_admin?).and_return(true)
      ReadersController.stub(:current_user).and_return(@user)
      Reader.should_receive(:all).and_return([@reader])
      get :index
      assigns(:readers).should == [@reader]
    end
    it "assigns all readers as @readers" do
      reader = Reader.create! valid_attributes
      get :index, {}, valid_session
      assigns(:readers).should eq([reader])
    end
  end

  describe "GET show" do
    it "assigns the requested reader as @reader" do
      reader = Reader.create! valid_attributes
      get :show, {:id => reader.to_param}, valid_session
      assigns(:reader).should eq(reader)
    end
  end

  describe "GET new" do
    it "assigns a new reader as @reader" do
      get :new, {}, valid_session
      assigns(:reader).should be_a_new(Reader)
    end
  end

  describe "GET edit" do
    it "assigns the requested reader as @reader" do
      reader = Reader.create! valid_attributes
      get :edit, {:id => reader.to_param}, valid_session
      assigns(:reader).should eq(reader)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Reader" do
        expect {
          post :create, {:reader => valid_attributes}, valid_session
        }.to change(Reader, :count).by(1)
      end

      it "assigns a newly created reader as @reader" do
        post :create, {:reader => valid_attributes}, valid_session
        assigns(:reader).should be_a(Reader)
        assigns(:reader).should be_persisted
      end

      it "redirects to the created reader" do
        post :create, {:reader => valid_attributes}, valid_session
        response.should redirect_to(Reader.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved reader as @reader" do
        # Trigger the behavior that occurs when invalid params are submitted
        Reader.any_instance.stub(:save).and_return(false)
        post :create, {:reader => {  }}, valid_session
        assigns(:reader).should be_a_new(Reader)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Reader.any_instance.stub(:save).and_return(false)
        post :create, {:reader => {  }}, valid_session
        response.should render_template("new")
      end
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

  describe "DELETE destroy" do
    it "destroys the requested reader" do
      reader = Reader.create! valid_attributes
      expect {
        delete :destroy, {:id => reader.to_param}, valid_session
      }.to change(Reader, :count).by(-1)
    end

    it "redirects to the readers list" do
      reader = Reader.create! valid_attributes
      delete :destroy, {:id => reader.to_param}, valid_session
      response.should redirect_to(readers_url)
    end
  end

end
