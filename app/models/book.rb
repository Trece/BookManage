# -*- coding: utf-8 -*-
class Book < ActiveRecord::Base
  attr_accessible :ISBN, :author, :description, :title, :total_num, :remain_num
  has_many :borrow_records
  has_many :borrowed_readers, through: :borrow_records, class_name: "Reader", source: :reader
  has_many :reserve_records
  has_many :reserved_readers, through: :reserve_records, class_name: "Reader", source: :reader

  def self.all_fields
    return ["标题", "作者"]
  end

  def has_remain
    remain_num > reserve_records.count
  end

  def is_in_reserve_list(reader)
    if self.reserve_records != nil
        if reserve_records.find_by_reader_id(reader.id) != nil
          return true
        end
    end
    return false
  end

  def borrowed_by(reader)
    if has_remain || is_in_reserve_list(reader) then
      update_attribute(:remain_num, remain_num - 1)
      borrowed_readers << reader

      if is_in_reserve_list(reader)
        reserved_readers.delete(reader)
      end
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

  def reserved_by(reader)
    if remain_num == 0 then
      reserved_readers << reader
    end
  end

  def unreserved_by(reader)
    begin
      if reserved_readers.find reader.id then
        reserved_readers.delete(reader)
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
