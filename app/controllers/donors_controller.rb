class DonorsController < ApplicationController
  def index
    @donors = Donor.all
  end
  
  def show
    @donor = Donor.find(params[:id])
  end
  
  def new
    @donor = Donor.new
  end
  
  def create
    @donor = Donor.new(params[:donor])
    if @donor.save
      flash[:notice] = "Successfully created donor."
      redirect_to @donor
    else
      render :action => 'new'
    end
  end
  
  def edit
    @donor = Donor.find(params[:id])
  end
  
  def update
    @donor = Donor.find(params[:id])
    if @donor.update_attributes(params[:donor])
      flash[:notice] = "Successfully updated donor."
      redirect_to @donor
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @donor = Donor.find(params[:id])
    @donor.destroy
    flash[:notice] = "Successfully destroyed donor."
    redirect_to donors_url
  end
end
