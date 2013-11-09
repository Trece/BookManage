# -*- coding: utf-8 -*-
class Book < ActiveRecord::Base
  attr_accessible :ISBN, :author, :description, :title, :total_num, :remain_num
  has_many :borrow_records
  has_many :borrowed_readers, through: :borrow_records, class_name: "Reader", source: :reader

  def self.search(type, keywords)
    if type == "标题"
      self.search_by_title(keywords)
    elsif type == "作者"
      self.search_by_author(keywords)
    end
  end

  def self.search_by_title(title)
    return Book.all(:conditions => ['title LIKE ?', "%" + title + "%"])
  end

  def self.search_by_author(author)
    return Book.all(:conditions => ['author LIKE ?', "%" + author + "%"])
  end
end
