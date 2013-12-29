# -*- coding: utf-8 -*-

class BooksController < ApplicationController

  protect_from_forgery

  before_filter :auth_flags

  # GET /books
  # GET /books.json
  def index
    if flash[:search_result].nil?
      @books = Book.all
    else
      @books = flash[:search_result]
    end

    @all_field = Book.all_fields

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])
    @readers = @book.borrowed_readers
    @can_reserve = can_reserve
    @can_unreserve = can_unreserve
    @reserved_time = @book.reserved_readers.count
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # POST /books/search
  def search
    type = params[:type]
    keywords = params[:keywords]
    search_result = Book.search(type, keywords)
    flash[:search_result] = search_result
    redirect_to books_url
  end

  def borrow_book
    book = Book.find(params[:id])
    begin
      reader = Reader.find_by_jobid(params[:reader_jobid])
    rescue NoMethodError
      flash[:error] = "Invalid ID"
      redirect_to admin_transfer_path(id: book.id)
      return
    end
    if reader == nil then
      flash[:error] = "Failed, not sign up yet"
    elsif !book.borrow_records.find_by_reader_id(reader.id).nil?
      flash[:error] = "Failed, you have borrowed this book"
    else
      if book.borrowed_by reader
        flash[:notice] = "Borrowed successfully"

        # set email reminder
        borrow_record = book.borrow_records.find_by_reader_id(reader.id)
        if borrow_record != nil
          borrow_record.set_return_reminder
        end
      else 
        flash[:error] = "Failed, no more book left or has been reserved"
      end
    end
    respond_to do |format|
      format.json { head :no_content}
      format.html { redirect_to admin_transfer_path(id: book.id) }
    end
  end

  def return_book
    book = Book.find(params[:id])
    begin
      reader = Reader.find_by_jobid(params[:reader_jobid])
    rescue NoMethodError
      flash[:error] = "Invalid ID"
      redirect_to admin_transfer_path(id: book.id)
    end
    if book.returned_by reader
      flash[:notice] = "Return successfully"
      # send notify email so that the reader can fetch reserved books
      if !book.reserve_records.empty?
        reserve_record = book.reserve_records[0]
        NotifyMailer.fetch_reserved_books(reserve_record).deliver
      end
    else
      flash[:error] = "You didn't borrowed this book"
    end
    respond_to do |format|
      format.json {head :no_content}
      format.html { redirect_to admin_transfer_path(id: book.id) }
    end
  end

  def reserve_book
    book = Book.find(params[:id])
    reader = current_reader
    if book.reserved_by reader then
      flash[:notice] = "Reserved successfully"
    else
      flash[:error] = "Failed, there's still books left"
    end
    respond_to do |format|
      format.json {head :no_content}
      format.html { redirect_to book_path(book) }
    end
  end

  def unreserve_book
    book = Book.find(params[:id])
    reader = current_reader
    if book.unreserved_by reader then
      flash[:notice] = "Unreserved successfully"
    else
      flash[:error] = "Failed, you didn't reserve it"
    end
    respond_to do |format|
      format.json {head :no_content}
      format.html { redirect_to book_path(book) }
    end
  end

  private

  def can_reserve
    @user_flag && (!@admin_flag) && @book.remain_num == 0 && !(@book.reserved_readers.include? current_reader)
  end

  def can_unreserve
    @user_flag && (!@admin_flag) && (@book.reserved_readers.include? current_reader)
  end

  def record_per_page
    10
  end

end
