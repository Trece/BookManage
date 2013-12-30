require 'spec_helper'

describe BorrowRecord do
  before :each do
    @book = Book.create(title: "Wang")
    @reader = Reader.create(name: "WW")
    @brecord = BorrowRecord.create(book: @book, reader: @reader)
  end

  describe "set_remainder" do
    it "should set a scheduler" do
      s = Rufus::Scheduler.new
      Rufus::Scheduler.stub(:new).and_return(s)
      @brecord.stub(:notify_time).and_return(10)
      s.should_receive(:at).with(10)
      @brecord.set_return_reminder
    end
  end

  describe "notify time" do
    it "should calculate the time" do
      @brecord.stub(:created_at).and_return(0)
      @brecord.notify_time.should == 12 * 24 * 3600
    end
  end

end
