class BorrowRecord < ActiveRecord::Base
  attr_accessible :book, :reader
  belongs_to :reader
  belongs_to :book

  def return_time
    t = created_at
    t + (14 * 24 * 3600)
  end
end
