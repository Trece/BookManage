class AdminController < ApplicationController

  def index
    @borrow_records_list = BorrowRecord.all
    @reserve_records_list = ReserveRecord.all
  end

end
