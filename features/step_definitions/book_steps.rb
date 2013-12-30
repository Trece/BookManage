Given /these books exist/ do |book_table|
  book_table.hashes.each do |book|
    Book.create! book
  end
end

Given /these borrow relations exist/ do |borrow_table|
  borrow_table.hashes.each do |borrow|
    book = Book.find_by_title(borrow[:book_title])
    reader = Reader.find_by_name(borrow[:reader_name])
    book.borrowed_by reader
  end
end

Given /many book in database/ do
  books = []
  (1..50).each do |num|
    books << {title: 'Book' + num.to_s, author: 'Lee', ISBN: num.to_s + 'a12312', description: 'It is book number 2', total_num: 1, remain_num: 1}
  end
  books.each do |book|
    Book.create! book
  end
end

Then /^I should (not )?see book "([^"]*)"$/ do |flag, book_title|
  if not flag
    page.body.should include(book_title)
  else
    page.body.should_not include(book_title)
  end
end

Then /^I should (not )?see "([^"]+)" button$/ do |anti, name|
  if anti then
    begin
      find_button(name).should be_nil
    rescue Capybara::ElementNotFound
    end
  else
    find_button(name).should_not be_nil
  end
end

Then /^open$/ do
  save_and_open_page
end
