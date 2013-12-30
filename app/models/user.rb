class User < ActiveRecord::Base
  attr_accessible :jobid, :name
  has_one :reader
  def self.login_url
    "http://fake-tsinghua-id.herokuapp.com/login/form/4b2437cf332ec565314c94163e3d93c5/0/users"
  end
  def self.appid
    "book_manage"
  end
  def self.ticket_url
    "http://fake-tsinghua-id.herokuapp.com/checkticket/" + self.appid + "/"
  end
  def is_admin?
    ["2010010001"].include? jobid
  end
end
