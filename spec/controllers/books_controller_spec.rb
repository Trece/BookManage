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

  describe "borrow book" do
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
      flash[:notice].should == "Failed, no more book left"
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

  describe "reserve book" do
    before :each do
      @book = FactoryGirl.build(:book, remain_num: 0)
      @reader = FactoryGirl.build(:reader, name: "Tom")
      Book.stub(:find).and_return(@book)
      controller.stub(:current_reader).and_return(@reader)
    end
    it "should call the reserve method" do
      @book.should_receive(:reserved_by).with(@reader)
      post :reserve_book, id: @book.id
    end
    it "should warn if book have remains" do
      @book.stub(:reserved_by)
      post :reserve_book, id: @book.id
      flash[:notice].should == "Failed, there's still books left"
    end
  end

  describe "unreserve book" do
    before :each do
      @book = FactoryGirl.build(:book, remain_num: 0)
      @reader = FactoryGirl.build(:reader, name: "Tom")
      Book.stub(:find).and_return(@book)
      controller.stub(:current_reader).and_return(@reader)
    end
    it "should call the unreserve method" do
      @book.should_receive(:unreserved_by).with(@reader)
      post :unreserve_book, id: @book.id
    end
    it "should warn if he hasn't reserve the book" do
      @book.stub(:unreserved_by).and_return(nil)
      post :unreserve_book, id: @book.id
      flash[:notice].should == "Failed, you didn't reserve it"
    end
  end
end
