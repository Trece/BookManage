Then /^I should (not )?see book "([^"]*)"$/ do |flag, book_title|
  if not flag
    page.body.should include(book_title)
  else
    page.body.should_not include(book_title)
  end
end
