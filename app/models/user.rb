class User < ActiveRecord::Base
  attr_accessible :jobid, :name
  has_one :reader
  def self.login_url
    "http://127.0.0.1:3030/login/form/3284d43331f3c7ec02be2c9bcc7f9d18/0/users"
  end
  def self.appid
    "bookmanage"
  end
  def self.ticket_url
    "http://127.0.0.1:3030/checkticket/bookmanage/"
  end
  def self.ip
    "101_5_121_237"
  end
  def is_admin?
    ["2010010001"].include? jobid
  end
end
