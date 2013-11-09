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
end
