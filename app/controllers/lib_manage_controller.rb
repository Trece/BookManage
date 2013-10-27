class LibManageController < ApplicationController
  def home
    @books = Book.find(:all)
  end
end
