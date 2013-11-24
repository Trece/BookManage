require 'spec_helper'

describe LibManageController do
  before(:each) do
    @reader = FactoryGirl.build(:reader)
  end
  describe "home" do
    it "should contain reader info" do
      controller.stub(:current_reader).and_return(@reader)
      get :home
      assigns(:reader).should == @reader
    end
  end
end
