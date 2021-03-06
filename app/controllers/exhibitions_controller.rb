class ExhibitionsController < ApplicationController
  
  
  # GET /exhibitions
  # GET /exhibitions.xml
  def index
    @exhibitions = Exhibition.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exhibitions }
    end
  end

  # GET /exhibitions/1
  # GET /exhibitions/1.xml
  def show
    @exhibition = Exhibition.find(params[:id])

    respond_to do |format|
      format.html # exhibition.html.erb
      format.xml  { render :xml => @exhibition }
    end
  end

  # GET /exhibitions/new
  # GET /exhibitions/new.xml
  def new
    @exhibition = Exhibition.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @exhibition }
    end
  end

  # GET /exhibitions/1/edit
  def edit
    @exhibition = Exhibition.find(params[:id])
  end

  # POST /exhibitions
  # POST /exhibitions.xml
  def create
    @exhibition = Exhibition.new(params[:exhibition])

    respond_to do |format|
      if @exhibition.save
        flash[:notice] = 'Exhibition was successfully created.'
        format.html { redirect_to(@exhibition) }
        format.xml  { render :xml => @exhibition, :status => :created, :location => @exhibition }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exhibition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exhibitions/1
  # PUT /exhibitions/1.xml
  def update
    params[:exhibition][:work_ids] ||= []  
    @exhibition = Exhibition.find(params[:id])

    respond_to do |format|
      if @exhibition.update_attributes(params[:exhibition])
        flash[:notice] = 'Exhibition was successfully updated.'
        format.html { redirect_to(@exhibition) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exhibition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exhibitions/1
  # DELETE /exhibitions/1.xml
  def destroy
    @exhibition = Exhibition.find(params[:id])
    @exhibition.destroy

    respond_to do |format|
      format.html { redirect_to(exhibitions_url) }
      format.xml  { head :ok }
    end
  end
end
