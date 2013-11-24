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

Then /^I should (not )?see book "([^"]*)"$/ do |flag, book_title|
  if not flag
    page.body.should include(book_title)
  else
    page.body.should_not include(book_title)
  end
end

Given /^I logined as admin$/ do
  headers = {}
  Rack::Utils.set_cookie_header!(headers, :user_id , 1)
  cookie_string = headers['Set-Cookie']
  Capybara.current_session.driver.browser.set_cookie(cookie_string)
end
