class DonorsController < ApplicationController
  before_filter do |c| 
    c.send(:require_role, :administrator) unless request.format.json?
  end

  def index
  	@donors = Donor.order(:last_name)

    ActiveRecord::Base.include_root_in_json = false
    respond_to do |wants|
      wants.html { @donors = Donor.order(:last_name) }
      wants.json {render_json Donor.order(:last_name).to_json(:only=>[:id], :methods => [:display_name]) }
    end
  end

  #  api for donor list

  def edit
    @donor = Donor.find(params[:id])
  end

  def update
  	@donor = Donor.find(params[:id])
  	if @donor.update_attributes(params[:donor])
  	  flash[:notice] = 'Donor was successfully created.'
  	  redirect_to donors_path
  	else
  	  render :action => :edit
  	end
  end

  def new
    @donor = Donor.new
  end

  def create
  	@donor = Donor.new(params[:donor])
  	if @donor.save
  		flash[:notice] = 'donors_path was successfully created.'
  		redirect_to donors_path
  	else
  		render :action => :new
  	end
  end

  def destroy
    @donor = Donor.find(params[:id])
    @donor.destroy

    respond_to do |format|
      format.html { redirect_to(donors_path) }
      format.xml  { head :ok }
    end
  end
end