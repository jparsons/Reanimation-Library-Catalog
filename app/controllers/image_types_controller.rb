class ImageTypesController < ApplicationController

  before_filter do |c| c.send(:require_role, :administrator) end

  # GET /image_types
  # GET /image_types.xml
  def index
    @image_types = ImageType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @image_types }
    end
  end

  # GET /image_types/1
  # GET /image_types/1.xml
  def show
    @image_type = ImageType.find(params[:id])

    respond_to do |format|
      format.html # image_type.html.erb
      format.xml  { render :xml => @image_type }
    end
  end

  # GET /image_types/new
  # GET /image_types/new.xml
  def new
    @image_type = ImageType.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @image_type }
    end
  end

  # GET /image_types/1/edit
  def edit
    @image_type = ImageType.find(params[:id])
  end

  # POST /image_types
  # POST /image_types.xml
  def create
    @image_type = ImageType.new(image_type_params)

    respond_to do |format|
      if @image_type.save
        flash[:notice] = 'ImageType was successfully created.'
        format.html { redirect_to image_types_path }
        format.xml  { render :xml => @image_type, :status => :created, :location => @image_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /image_types/1
  # PUT /image_types/1.xml
  def update
    @image_type = ImageType.find(params[:id])

    respond_to do |format|
      if @image_type.update_attributes(image_type_params)
        flash[:notice] = 'ImageType was successfully updated.'
        format.html { redirect_to image_types_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /image_types/1
  # DELETE /image_types/1.xml
  def destroy
    @image_type = ImageType.find(params[:id])
    @image_type.destroy

    respond_to do |format|
      format.html { redirect_to(image_types_url) }
      format.xml  { head :ok }
    end
  end

  private

  def image_type_params
    params.require(:image_type).permit(
      :name
    )
  end
end
