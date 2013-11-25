require "spec_helper"

describe BooksController do
  describe "routing" do

    it "routes to #index" do
      get("/books").should route_to("books#index")
    end

    it "routes to #show" do
      get("/books/1").should route_to("books#show", :id => "1")
    end

    it "routes to #search" do
      post("/books/search").should route_to("books#search")
    end
    
    it "routes to #borrow" do
      post("/books/1/borrow_book").should route_to("books#borrow_book", id: "1")
    end
  end
end
