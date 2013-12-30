class NotifyMailer < ActionMailer::Base
  default from: "noreplay@library.iiis.com"

  def ask_for_return_for(b_record)
    @reader = b_record.reader
    @book = b_record.book
    @record = b_record
    mail(to: @reader.email, subject: "Please return the book that you borrow")
  end

  def fetch_reserved_books(r_record)
    @reader = r_record.reader
    @book = r_record.book
    @record = r_record
    mail(to: @reader.email, subject: "Please fetch your reserved books")
  end


end
