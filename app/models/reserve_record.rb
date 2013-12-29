require 'rufus-scheduler'
require 'notify_mailer'

class ReserveRecord < ActiveRecord::Base
  attr_accessible :book, :reader
  belongs_to :reader
  belongs_to :book
  
  def fetch_time_limit
  	DateTime.now + 3
  end
end
