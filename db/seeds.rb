# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

books = [{:title => 'Moonlight', :author => 'Alice', :ISBN => 'ABCDETTTFG124', :description => 'It is a wonderful book', :total_num => 3, :remain_num => 2},
         {:title => 'Sunshine', :author => 'Bob', :ISBN => 'ABCDEFG133224', :description => 'It is also a wonderful book', :total_num => 3, :remain_num => 3},
         {:title => 'My life', :author => 'Chris', :ISBN => 'AB23EFG124', :description => 'Bad book about a prisoner', :total_num => 1,:remain_num => 0}]

(1..50).each do |num|
  books << {title: 'Book' + num.to_s, author: 'Lee', ISBN: num.to_s + 'a12312', description: 'It is book number 2', total_num: 1, remain_num: 0}
end

books.each do |book|
  Book.create! book
end

readers = [{:name => 'Tom', :email => 'haha@o.com', :phone => '12345678910'},
          {:name => 'Ann', :email => 'new.k@hi.com', :phone => '1123581321'},]

readers.each do |reader|
  Reader.create! reader
end

borrow_records = [{:reader => Reader.find_by_name('Tom'), :book => Book.find_by_title('Moonlight')},
                  {:reader => Reader.find_by_name('Tom'), :book => Book.find_by_title('My life')}]

borrow_records.each do |record|
  BorrowRecord.create! record
end

reserve_records = [{:reader => Reader.find_by_name('Ann'), :book => Book.find_by_title('My life')}]

reserve_records.each do |record|
  ReserveRecord.create! record
end
