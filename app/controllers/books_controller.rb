# -*- coding: utf-8 -*-
class BooksController < ApplicationController
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

  # GET /books/new
  # GET /books/new.json
#  def new
#    @book = Book.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @book }
#    end
#  end

  # GET /books/1/edit
#  def edit
#    @book = Book.find(params[:id])
#  end
#
  # POST /books
  # POST /books.json
#  def create
#    @book = Book.new(params[:book])
#
#    respond_to do |format|
#      if @book.save
#        format.html { redirect_to @book, notice: 'Book was successfully created.' }
#        format.json { render json: @book, status: :created, location: @book }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @book.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  # PUT /books/1
  # PUT /books/1.json
#  def update
#    @book = Book.find(params[:id])
#
#    respond_to do |format|
#      if @book.update_attributes(params[:book])
#        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
#        format.json { head :no_content }
#      else
#        format.html { render action: "edit" }
#        format.json { render json: @book.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /books/1
  # DELETE /books/1.json
#  def destroy
#    @book = Book.find(params[:id])
#    @book.destroy
#
#    respond_to do |format|
#      format.html { redirect_to books_url }
#      format.json { head :no_content }
#    end
#  end

  # POST /books/search
  def search
    type = params[:type]
    keywords = params[:keywords]

    search_result = Book.search(type, keywords)

    flash[:search_result] = search_result
    redirect_to books_url
  end
  
  # GET /books/borrow/:id
  def borrow_book
    book = Book.find(params[:id])
    reader = Reader.find_by_name(params[:reader_name])
    if book.remain_num > 0
      book.borrowed_by reader
      flash[:notice] = "Borrowed successfully"
    else
      flash[:notice] = "No more book left"
    end
    redirect_to book_path(book)
  end

  # GET /books/borrow/:id
  def return_book
    book = Book.find(params[:id])
    reader = Reader.find_by_name(params[:reader_name])
    if book.returned_by reader
      flash[:notice] = "Return successfully"
    else
      flash[:notice] = "You didn't borrowed this book"
    end
    redirect_to book_path(book)
  end
end
