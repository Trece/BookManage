require 'spec_helper'

describe AdminController do

  describe "find book" do
    it "should find the books" do
      Book.should_receive(:search).with("title", "sun").and_return([])
      get :find_book, type: "title", keywords: "sun"
    end
  end

end
