require 'rufus-scheduler'
require 'notify_mailer'

class BorrowRecord < ActiveRecord::Base
  attr_accessible :book, :reader
  belongs_to :reader
  belongs_to :book

  def return_time
    t = created_at
    t + (14 * 24 * 3600)
  end
  
  def notify_time
  	created_at
    #return_time - (2 * 24 * 3600)
  end
  
  def set_return_reminder
    scheduler = Rufus::Scheduler.new
    notify_time = self.notify_time
    
    scheduler.at notify_time do
      NotifyMailer.ask_for_return_for(self).deliver
    end
  end
end
