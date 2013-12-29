Given /these readers exist/ do |reader_table|
  reader_table.hashes.each do |reader|
    new_reader = Reader.create! reader
    new_reader.user = User.find_by_name(reader["name"])
    new_reader.save
  end
end

Given /these users exist/ do |user_table|
  user_table.hashes.each do |user|
    User.create! user
  end
end

Given /^I login as admin$/ do
  Net::HTTP.stub(:get).and_return("zjh=2010010001:xm=John:email=ek@tsinghua.edu")
  visit users_path
end

Given /^I login as normal user with jobid "(.+?)", name "(.+?)", email "(.+?)"$/ do |jobid, name, email|
  Net::HTTP.stub(:get).and_return("zjh=#{jobid}:xm=#{name}:email=#{email}")
  visit users_path
end
