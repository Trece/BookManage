class ReadersController < ApplicationController

  before_filter :auth_reader, except: :index
  before_filter :auth_admin, only: :index

  # GET /readers
  # GET /readers.json
  def index
    @readers = Reader.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @readers }
    end
  end

  # GET /readers/1
  # GET /readers/1.json
  def show
    @reader = current_reader
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reader }
    end
  end

  # GET /readers/1/edit
  def edit
    @reader = Reader.find(params[:id])
  end


  # PUT /readers/1
  # PUT /readers/1.json
  def update
    @reader = Reader.find(params[:id])

    respond_to do |format|
      if @reader.update_attributes(params[:reader])
        format.html { redirect_to @reader, notice: 'Reader was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reader.errors, status: :unprocessable_entity }
      end
    end
  end

end
