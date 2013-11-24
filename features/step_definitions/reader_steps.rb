Given /these readers exist/ do |reader_table|
  reader_table.hashes.each do |reader|
    Reader.create! reader
  end
end
