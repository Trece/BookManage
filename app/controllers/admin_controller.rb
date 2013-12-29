class AdminController < ApplicationController

  def index
    redirect_to admin_status_path
  end

  def status
    @borrow_records_list = BorrowRecord.all
    @reserve_records_list = ReserveRecord.all
  end

  def transfer
    @all_field = Book.all_fields
  end



end
