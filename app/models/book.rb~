class Book < ActiveRecord::Base
  attr_accessible :ISBN, :author, :description, :title, :total_num, :remain_num
  has_many :borrow_records
  has_many :borrowed_readers, through: :borrow_records, class_name: "Reader", source: :reader
end
