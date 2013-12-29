class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def current_user
    begin
      unless @user then
        if session[:user_id] then
          @user = User.find(session[:user_id])
        end
      end
      @user
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

  def current_reader
    if current_user and current_user.reader then
      current_user.reader
    end
  end

  def auth_reader
    if current_reader and current_reader.id == params[:id].to_i then
      true
    else
      flash[:notice] = "Permission denied"
      redirect_to home_path
      false
    end

  end

  def auth_admin
    unless current_user and current_user.is_admin? then
      flash[:notice] = "Permission denied"
      redirect_to home_path
      false
    end
  end

  def auth_flags
    if current_user then
      @user_flag = true
    else
      @user_flag = false
    end
    if current_user and current_user.is_admin? then
      @admin_flag = true
    else
      @admin_flag = false
    end
  end

  helper_method :current_user
  helper_method :current_reader

end
