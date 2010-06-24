class VendorsController < ApplicationController
  def index
    @vendors = Vendor.all
  end
  
  def show
    @vendor = Vendor.find(params[:id])
  end
  
  def new
    @vendor = Vendor.new
    respond_to do |format|
      format.html # index.html.erb
      format.js { render :layout => false }
    end
  end
  
  def create
    @vendor = Vendor.new(params[:vendor])
    if @vendor.save
      flash[:notice] = "Successfully created vendor."
      redirect_to @vendor
    else
      render :action => 'new'
    end
  end
  
  def edit
    @vendor = Vendor.find(params[:id])
  end
  
  def update
    @vendor = Vendor.find(params[:id])
    if @vendor.update_attributes(params[:vendor])
      flash[:notice] = "Successfully updated vendor."
      redirect_to @vendor
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @vendor = Vendor.find(params[:id])
    @vendor.destroy
    flash[:notice] = "Successfully destroyed vendor."
    redirect_to vendors_url
  end
end
