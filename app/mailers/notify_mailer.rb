class NotifyMailer < ActionMailer::Base
  default from: "noreplay@library.iiis.com"
  
  def ask_for_return_for(b_record)
    @reader = b_record.reader
    @book = b_record.book
    @record = b_record
    mail(to: "winmad.wlf@gmail.com", subject: "Please return the book that you borrow")
  end

  def test_mail()
    mail(to: "treamug@gmail.com, subject: "TEST")
  end
end
