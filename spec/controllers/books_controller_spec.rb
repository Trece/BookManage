require 'spec_helper'

describe BooksController do

  let(:valid_attributes) { {  } }
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all books as @books" do
      book = Book.create! valid_attributes
      get :index, {}, valid_session
      assigns(:books).should eq([book])
    end
  end

  describe "GET show" do
    it "assigns the requested book as @book" do
      book = Book.create! valid_attributes
      get :show, {:id => book.to_param}, valid_session
      assigns(:book).should eq(book)
    end
  end

  describe "POST search" do
    it "finds books by keys" do
      fake_results = [mock('book1'), mock('book2')]
      Book.should_receive(:search).and_return(fake_results)
      post :search, {:type => :title, :keywords => "book"}, valid_session
    end

    it "redirects to the books list with search result" do
      fake_search_result = [mock('book1'), mock('book2')]
      post :search, {:type => :title, :keywords => "book"}, valid_session
      response.should redirect_to(books_url)
    end
  end

  describe "Borrow book" do
    it "should call the borrow method" do
      book = FactoryGirl.build(:book, remain_num: 2)
      reader = FactoryGirl.build(:reader, name: "Tom")
      Book.stub(:find).and_return(book)
      Reader.stub(:find_by_name).and_return(reader)
      book.should_receive(:borrowed_by).with(reader)
      post :borrow_book, id: book.id, reader_name: reader.name
    end
    it "should give notice if no book is left" do
      book = FactoryGirl.build(:book, remain_num: 0)
      reader = FactoryGirl.build(:reader, name: "Tom")
      Book.stub(:find).and_return(book)
      Reader.stub(:find_by_name).and_return(reader)
      book.stub(:borrowed_by)
      post :borrow_book, id: book.id, reader_name: reader.name
      flash[:notice].should == "No more book left"
    end
  end
  
  describe "return book" do
    it "should call the instance method return" do
      book = FactoryGirl.build(:book, remain_num: 0)
      reader = FactoryGirl.build(:reader, name: "Tom")
      Book.stub(:find).and_return(book)
      Reader.stub(:find_by_name).and_return(reader)
      book.should_receive(:returned_by).with(reader)
      post :return_book, id: book.id, reader_name: reader.name
    end
  end
end
