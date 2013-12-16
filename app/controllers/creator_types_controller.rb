class CreatorTypesController < ApplicationController
  before_filter do |c| c.send(:require_role, :administrator) end

  # GET /creator_types
  # GET /creator_types.xml
  def index
    @creator_types = CreatorType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @creator_types }
    end
  end

  # GET /creator_types/1
  # GET /creator_types/1.xml
  def show
    @creator_type = CreatorType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @creator_type }
    end
  end

  # GET /creator_types/new
  # GET /creator_types/new.xml
  def new
    @creator_type = CreatorType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @creator_type }
    end
  end

  # GET /creator_types/1/edit
  def edit
    @creator_type = CreatorType.find(params[:id])
  end

  # POST /creator_types
  # POST /creator_types.xml
  def create
    @creator_type = CreatorType.new(params[:creator_type])

    respond_to do |format|
      if @creator_type.save
        format.html { redirect_to(creator_types_path, :notice => 'Creator type was successfully created.') }
        format.xml  { render :xml => @creator_type, :status => :created, :location => @creator_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @creator_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /creator_types/1
  # PUT /creator_types/1.xml
  def update
    @creator_type = CreatorType.find(params[:id])

    respond_to do |format|
      if @creator_type.update_attributes(params[:creator_type])
        format.html { redirect_to(creator_types_path, :notice => 'Creator type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @creator_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /creator_types/1
  # DELETE /creator_types/1.xml
  def destroy
    @creator_type = CreatorType.find(params[:id])
    @creator_type.destroy

    respond_to do |format|
      format.html { redirect_to(creator_types_url) }
      format.xml  { head :ok }
    end
  end
end
