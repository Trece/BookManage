class NotifyMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def ask_for_return_for(b_record)
    @reader = b_record.reader
    @book = b_record.book
    @record = b_record
    mail(to: @reader.email, subject: "Please return the book that you borrow")
  end
end
