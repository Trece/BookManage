module ApplicationHelper
  def is_admin
    true
  end
  def user_reader
    Reader.find(1)
  end
end
