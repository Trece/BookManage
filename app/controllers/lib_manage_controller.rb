class LibManageController < ApplicationController
  def home
    @login_url = User.login_url
    @all_field = Book.all_fields
    @reader = current_reader

    if current_user != nil && current_user.is_admin?
      redirect_to admin_status_path
    end
  end
end
