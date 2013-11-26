require 'uri'
require 'net/http'

class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    ticket = params[:ticket]
    ip = request.remote_ip.gsub(/[.]/, '_')

    response = Net::HTTP.get(URI.parse(User.ticket_url + "#{ticket}/#{ip}"))
    if response == '' or /code=1/.match(response) then
      flash[:notice] = "Login Failed"
    else
      jobid = /zjh=(\d+)/.match(response)[1]
      name = /xm=([^:]+)/.match(response)[1]
      email = /email=([^\b:]+)/.match(response)[1]
      user = User.find_by_jobid(jobid)
      if user
        user.update_attributes(name: name)
      else
        user = User.create(jobid: jobid, name: name)
      end
      if user.reader
        user.reader.update_attributes(name: name)
      else
        reader = Reader.create(name: name, email: email, user: user)
      end
      session[:user_id] = user.id
      @user = user
    end
    redirect_to home_path
  end

  # GET /users/:id/logout
  def logout
    session[:user_id] = nil
    redirect_to home_path
  end

end
