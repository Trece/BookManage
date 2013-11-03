# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

books = [{:name => 'Moonlight', :ISBN => 'ABCDETTTFG124', :description => 'It is a wonderful book', :total => 3, :remain => 1},
         {:name => 'Sunshine', :ISBN => 'ABCDEFG133224', :description => 'It is also a wonderful book', :total => 3, :remain => 3},
         {:name => 'My life', :ISBN => 'AB23EFG124', :description => 'Bad book about a prisoner', :total => 1, :remain => 1}]

Book.send(:attr_accessible, :name, :ISBN, :description, :total, :remain)
books.each do |book|
  Book.create! book
end

readers = [{:name => 'Tom', :email => 'haha@o.com', :phone => '12345678910'},
          {:name => 'Ann', :email => 'new.k@hi.com', :phone => '1123581321'},]
Reader.send(:attr_accessible, :name, :email, :phone)
readers.each do |reader|
  Reader.create! reader
end
