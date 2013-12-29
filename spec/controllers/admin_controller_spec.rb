require 'spec_helper'

describe AdminController do

  describe "find book" do
    it "should find the books" do
      #Book.should_receive(:search)
      get :index
    end
  end

end
