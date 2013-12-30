require 'spec_helper'

describe AdminController do
  before :each do
    @controller.stub(:auth_admin).and_return(true)
  end

  describe "find book" do
    it "should find the books" do
      Book.should_receive(:search).and_return([])
      get :find_book, type: "Ha", keywords: "Wang"
    end
    
  end

  describe "status display" do
    it "should return record list" do
      b_list = [mock('s'),]
      r_list = [mock('d'),]
      BorrowRecord.stub(:all).and_return(b_list)
      ReserveRecord.stub(:all).and_return(r_list)
      get :status
      assigns[:borrow_records_list].should == b_list
    end
  end

  describe "transfer" do
    before :each do
      @book = FactoryGirl.build(:book)
      @fields = [mock('s')]
      @breaders = [FactoryGirl.build(:reader), FactoryGirl.build(:reader)]
      @rreaders = [FactoryGirl.build(:reader)]
    end
    it "should assigns the variables" do
      Book.stub(:find).and_return(@book)
      Book.stub(:all_fields).and_return(@fields)
      @book.stub(:borrowed_readers).and_return(@breaders)
      @book.stub(:reserved_readers).and_return(@rreaders)
      get :transfer, id: 2
      assigns[:book].should == @book
      assigns[:all_field].should == @fields
      assigns[:readers].should == @breaders
      assigns[:reserved_time].should == 1
    end
  end

end
