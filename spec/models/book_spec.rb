# -*- coding: utf-8 -*-
require 'spec_helper'

describe Book do
  describe "searing books by keywords of given type" do
    it "should search books by title" do
      Book.should_receive(:all).with(hash_including :conditions => ['title LIKE ?', "%Moon%"])
      Book.search_by_title("Moon")
    end

    it "should search books by author" do
      Book.should_receive(:all).with(hash_including :conditions => ['author LIKE ?', "%Alice%"])
      Book.search_by_author("Alice")
    end

    it "should search books by keywords of given type" do
      Book.should_receive(:search_by_title).with("Moon")
      Book.search("标题", "Moon")

      Book.should_receive(:search_by_author).with("Alice")
      Book.search("作者", "Alice")
    end
  end

  describe "Borrow books" do
    before :each do
      @book = Book.create(title: "Aha", author: "Xi", total_num:3, remain_num:2)
      @reader = Reader.create(name: "Tom")
    end
    it "should decr the number correctly" do
      Book.stub(:borrowed_readers).and_return([])
      @book.borrowed_by @reader
      @book.remain_num.should == 1
    end
    it "should create a borrow record when borrowed" do
      BorrowRecord.find_by_reader_id_and_book_id(@reader.id, @book.id).should == nil
      record = @book.borrowed_by @reader
      BorrowRecord.find_by_reader_id_and_book_id(@reader.id, @book.id).should_not == nil
    end
    it "should not decr the number when no book left" do
      @book.remain_num = 0
      @book.borrowed_by @reader
      @book.remain_num.should == 0
    end
    it "should return nil when no book's left" do
      @book.remain_num = 0
      record = @book.borrowed_by @reader
      record.should == nil
    end
    it "should return nil when the books are reserved" do
      @reader_1 = Reader.create(name: "John")
      @reader_2 = Reader.create(name: "Tim")
      ReserveRecord.create(book: @book, reader: @reader_1)
      ReserveRecord.create(book: @book, reader: @redder_2)
      @book.borrowed_by(@reader).should == nil
    end
  end

  describe "Return books" do
    before :each do
      @book = Book.create(title: "Aha", author: "Xi", total_num:3, remain_num:0)
      @reader = Reader.create(name: "Tom")
    end
    it "should incr the number" do
      BorrowRecord.create(reader: @reader, book: @book)
      @book.returned_by @reader
      @book.remain_num.should == 1
    end
    it "should remove the record" do
      BorrowRecord.create(reader: @reader, book: @book)
      @book.returned_by @reader
      BorrowRecord.find_by_reader_id_and_book_id(@reader.id, @book.id).should == nil
    end
    it "should return nil when reader didn't borrow the book" do
      BorrowRecord.find_by_reader_id_and_book_id(@reader.id, @book.id).should == nil
      result = @book.returned_by @reader
      result.should == nil
    end
  end

  describe "Reserve book" do
    before :each do
      @book = Book.create(title: "Aha", author: "Xi", total_num: 3, remain_num: 0)
      @reader = Reader.create(name: "Tom")
    end
    it "should add a reader to the list" do
      ReserveRecord.find_by_reader_id_and_book_id(@reader.id, @book.id).should == nil
      @book.reserved_by @reader
      ReserveRecord.find_by_reader_id_and_book_id(@reader.id, @book.id).should_not == nil
    end
    it "shouldn't add it if the book has remain number" do
      @book.update_attribute(:remain_num, 2)
      @book.reserved_by(@reader).should == nil
      ReserveRecord.find_by_reader_id_and_book_id(@reader.id, @book.id).should == nil
    end
  end

  describe "Unreserve book" do
    before :each do
      @book = Book.create(title: "Aha", author: "Xi", total_num: 3, remain_num: 0)
      @reader = Reader.create(name: "Tom")
      ReserveRecord.create(book: @book, reader: @reader)
    end
    it "should remove the record" do
      @book.unreserved_by @reader
      ReserveRecord.find_by_book_id_and_reader_id(@book.id, @reader.id).should == nil
    end
  end
end
