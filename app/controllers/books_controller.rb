# -*- coding: utf-8 -*-
require 'debugger'
class BooksController < ApplicationController

  protect_from_forgery :except => [:borrow_book, :return_book]

  before_filter :auth_admin_no_redirect

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
    reader = Reader.find_by_name(params[:reader_name])
    if book.remain_num > 0
      if reader == nil then
        flash[:notice] = "Not sign up yet"
      else
        book.borrowed_by reader
        flash[:notice] = "Borrowed successfully"
      end
    else
      flash[:notice] = "No more book left"
    end
    respond_to do |format|
      format.json { head :no_content}
      format.html { redirect_to book_path(book) }
    end
  end

  def return_book
    book = Book.find(params[:id])
    reader = Reader.find_by_name(params[:reader_name])
    if book.returned_by reader
      flash[:notice] = "Return successfully"
    else
      flash[:notice] = "You didn't borrowed this book"
    end
    respond_to do |format|
      format.json {head :no_content}
      format.html { redirect_to book_path(book) }
    end
  end
end
