class Reader < ActiveRecord::Base
  attr_accessible :email, :name, :phone, :user
  has_many :borrow_records
  has_many :borrowed_books, through: :borrow_records, class_name: "Book", source: :book
  has_many :reserve_records
  has_many :reserved_books, through: :reserve_records, class_name: "Book", source: :book
  belongs_to :user

  def self.find_by_jobid(jobid)
    User.find_by_jobid(jobid).reader
  end
end
