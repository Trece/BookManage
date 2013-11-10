class LibManageController < ApplicationController
  def home
    @all_field = Book.all_fields
  end
end
