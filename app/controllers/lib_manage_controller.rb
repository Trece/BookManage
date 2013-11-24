class LibManageController < ApplicationController
  def home
    @login_url = User.login_url
    @all_field = Book.all_fields
  end
end
