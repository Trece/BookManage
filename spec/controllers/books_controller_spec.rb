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

  describe "GET new" do
    it "assigns a new book as @book" do
      get :new, {}, valid_session
      assigns(:book).should be_a_new(Book)
    end
  end

  describe "GET edit" do
    it "assigns the requested book as @book" do
      book = Book.create! valid_attributes
      get :edit, {:id => book.to_param}, valid_session
      assigns(:book).should eq(book)
    end
  end
  describe "POST create" do
    describe "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, {:book => valid_attributes}, valid_session
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created book as @book" do
        post :create, {:book => valid_attributes}, valid_session
        assigns(:book).should be_a(Book)
        assigns(:book).should be_persisted
      end

      it "redirects to the created book" do
        post :create, {:book => valid_attributes}, valid_session
        response.should redirect_to(Book.last)
      end
    end

   describe "with invalid params" do
      it "assigns a newly created but unsaved book as @book" do
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        post :create, {:book => {  }}, valid_session
        assigns(:book).should be_a_new(Book)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        post :create, {:book => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested book" do
        book = Book.create! valid_attributes
        # Assuming there are no other books in the database, this
       # specifies that the Book created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Book.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => book.to_param, :book => { "these" => "params" }}, valid_session
      end

      it "assigns the requested book as @book" do
        book = Book.create! valid_attributes
        put :update, {:id => book.to_param, :book => valid_attributes}, valid_session
        assigns(:book).should eq(book)
      end

      it "redirects to the book" do
        book = Book.create! valid_attributes
        put :update, {:id => book.to_param, :book => valid_attributes}, valid_session
        response.should redirect_to(book)
      end
    end

    describe "with invalid params" do
      it "assigns the book as @book" do
       book = Book.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        put :update, {:id => book.to_param, :book => {  }}, valid_session
        assigns(:book).should eq(book)
      end

      it "re-renders the 'edit' template" do
        book = Book.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
       Book.any_instance.stub(:save).and_return(false)
        put :update, {:id => book.to_param, :book => {  }}, valid_session
        response.should render_template("edit")
     end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested book" do
      book = Book.create! valid_attributes
      expect {
        delete :destroy, {:id => book.to_param}, valid_session
      }.to change(Book, :count).by(-1)
    end

    it "redirects to the books list" do
      book = Book.create! valid_attributes
      delete :destroy, {:id => book.to_param}, valid_session
      response.should redirect_to(books_url)
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
