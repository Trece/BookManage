Given /these readers exist/ do |reader_table|
  reader_table.hashes.each do |reader|
    reader["user"] = User.find_by_name(reader["name"])
    Reader.create! reader
  end
end

Given /these users exist/ do |user_table|
  user_table.hashes.each do |user|
    User.create! user
  end
end

Given /^I logined as admin$/ do
  headers = {}
  Rack::Utils.set_cookie_header!(headers, :user_id , 1)
  cookie_string = headers['Set-Cookie']
  Capybara.current_session.driver.browser.set_cookie(cookie_string)
end
