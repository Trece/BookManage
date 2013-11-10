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
    it "should decr the number correctly" do
      book = Book.create(title: "Aha", author: "Xi", total_num:3, remain_num:2)
      reader = Reader.create(name: "Tom")
      Book.stub(:borrowed_readers).and_return([])
      book.borrowed_by reader
      book.remain_num.should == 1
    end
    it "should create a borrow record when borrowed" do
      book = Book.create(title: "Aha", author: "Xi", total_num:3, remain_num:2)
      reader = Reader.create(name: "Tom")
      BorrowRecord.find_by_reader_id_and_book_id(reader.id, book.id).should == nil
      record = book.borrowed_by reader
      BorrowRecord.find_by_reader_id_and_book_id(reader.id, book.id).should_not == nil
    end
    it "should not decr the number when no book left" do
      book = Book.create(title: "Aha", author: "Xi", total_num:3, remain_num:0)
      reader = Reader.create(name: "Tom")
      book.borrowed_by reader
      book.remain_num.should == 0
    end
    it "should return nil when no book's left" do
      book = Book.create(title: "Aha", author: "Xi", total_num:3, remain_num:0)
      reader = Reader.create(name: "Tom")
      record = book.borrowed_by reader
      record.should == nil
    end
  end

  describe "Return books" do
    it "should incr the number" do
      book = Book.create(title: "Aha", author: "Xi", total_num:3, remain_num:0)
      reader = Reader.create(name: "Tom")
      BorrowRecord.create(reader: reader, book: book)
      book.returned_by reader
      book.remain_num.should == 1
    end
    it "should remove the record" do
      book = Book.create(title: "Aha", author: "Xi", total_num:3, remain_num:0)
      reader = Reader.create(name: "Tom")
      BorrowRecord.create(reader: reader, book: book)
      book.returned_by reader
      BorrowRecord.find_by_reader_id_and_book_id(reader.id, book.id).should == nil
    end
    it "should return nil when reader didn't borrow the book" do
      book = Book.create(title: "Aha", author: "Xi", total_num:3, remain_num:0)
      reader = Reader.create(name: "Tom")
      BorrowRecord.find_by_reader_id_and_book_id(reader.id, book.id).should == nil
      result = book.returned_by reader
      result.should == nil
    end
  end
end
