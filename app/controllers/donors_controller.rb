class DonorsController < ApplicationController
  before_filter do |c| c.send(:require_role, :administrator) end

  def index
  	@donors = Donor.order(:last_name)
  end

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