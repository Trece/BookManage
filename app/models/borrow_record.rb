class BorrowRecord < ActiveRecord::Base
  attr_accessible :book, :reader
  belongs_to :reader
  belongs_to :book
end
