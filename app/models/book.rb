# -*- coding: utf-8 -*-
class Book < ActiveRecord::Base
  attr_accessible :ISBN, :author, :description, :title, :total_num, :remain_num
  has_many :borrow_records
  has_many :borrowed_readers, through: :borrow_records, class_name: "Reader", source: :reader

  def self.all_fields
    return ["标题", "作者"]
  end
  
  def borrowed_by(reader)
    if remain_num > 0
      update_attribute(:remain_num, remain_num - 1)
      borrowed_readers << reader
      true
    else
      nil
    end
  end

  def returned_by(reader)
    begin
      if borrowed_readers.find reader.id
        borrowed_readers.delete(reader)
        update_attribute(:remain_num, remain_num + 1)
      end
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

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
