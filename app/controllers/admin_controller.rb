class AdminController < ApplicationController

  def index
    redirect_to admin_status_path
  end

  def status
    @borrow_records_list = BorrowRecord.all
    @reserve_records_list = ReserveRecord.all
  end

  def find_book
    @all_field = Book.all_fields
    if params[:type] && params[:keywords] then
      @books = Book.search(params[:type], params[:keywords])
    else
      @books = Book.first(record_per_page)
    end
  end

  def transfer
    @all_field = Book.all_fields
    @book = Book.find(params[:id])
    @readers = @book.borrowed_readers
  end

  protected
  def record_per_page
    10
  end

end
