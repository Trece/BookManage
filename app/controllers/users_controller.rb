require 'uri'
require 'net/http'
require 'debugger'

class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    ticket = params[:ticket]
    ip = request.remote_ip.gsub(/[.]/, '_')

    if Settings.ip then
      ip = Settings.ip
    end

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

  # GET /users/login
  def login
    #redirect_to User.login_url
    session[:user_id] = 1
    redirect_to home_path
  end

  # GET /users/:id/logout
  def logout
    session[:user_id] = nil
    redirect_to home_path
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
