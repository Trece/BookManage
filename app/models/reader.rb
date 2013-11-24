class Reader < ActiveRecord::Base
  attr_accessible :email, :name, :phone, :user
  has_many :borrow_records
  has_many :borrowed_books, through: :borrow_records, class_name: "Book", source: :book
  belongs_to :user
end
