class AdminController < ApplicationController

  before_filter :auth_admin

  def index
    redirect_to admin_status_path
  end

  def status
    @borrow_records_list = BorrowRecord.all
    @reserve_records_list = ReserveRecord.all
  end

  def find_book
    @page = (if params[:page] then params[:page] else 1 end).to_i
    @all_field = Book.all_fields
    if params[:type] != nil && params[:keywords] != nil then
      type = params[:type]
      keywords = params[:keywords]
      type ||= session[:type]
      keywords ||= session[:keywords]
      @books = Book.search(type, keywords)
      session[:type] = type
      session[:keywords] = keywords
    else
      @books = Book.all
    end
    @page_limit = (@books.count - 1)/ record_per_page
    @books = @books.slice(record_per_page * (@page-1), record_per_page * @page)
  end

  def transfer
    @all_field = Book.all_fields
    @book = Book.find(params[:id])
    @readers = @book.borrowed_readers
    @reserved_time = @book.reserved_readers.count
  end

  protected
  def record_per_page
    30
  end

end
