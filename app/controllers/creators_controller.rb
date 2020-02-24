class CreatorsController < ApplicationController
  before_action do |c| c.send(:require_role, :administrator) end

  # GET /creators
  # GET /creators.xml
  def index
    @creators = Creator.order(:last_name, :first_name)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @creators }
    end
  end

  # GET /creators/1
  # GET /creators/1.xml
  def show
    @creator = Creator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @creator }
    end
  end

  # GET /creators/new
  # GET /creators/new.xml
  def new
    @creator = Creator.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @creator }
    end
  end

  # GET /creators/1/edit
  def edit
    @creator = Creator.find(params[:id])
  end

  # POST /creators
  # POST /creators.xml
  def create
    @creator = Creator.new(creator_params)

    respond_to do |format|
      if @creator.save
        format.html { redirect_to(creators_path, :notice => 'Creator type was successfully created.') }
        format.xml  { render :xml => @creator, :status => :created, :location => @creator }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @creator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /creators/1
  # PUT /creators/1.xml
  def update
    @creator = Creator.find(params[:id])

    respond_to do |format|
      if @creator.update_attributes(creator_params)
        format.html { redirect_to(creators_path, :notice => 'Creator type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @creator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /creators/1
  # DELETE /creators/1.xml
  def destroy
    @creator = Creator.find(params[:id])
    @creator.destroy

    respond_to do |format|
      format.html { redirect_to(creators_url) }
      format.xml  { head :ok }
    end
  end

  private

  def creator_params
    params.require(:creator).permit(
      :first_name,
      :last_name,
      :name_suffix,
      :creator_type_id
    )
  end

end
