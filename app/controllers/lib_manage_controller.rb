class LibManageController < ApplicationController
  def home
    @login_url = User.login_url
    @all_field = Book.all_fields
    @reader = current_reader
  end
end
