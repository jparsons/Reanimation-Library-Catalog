class DigitalAssetsController < ApplicationController
  def index
    @digital_assets = DigitalAsset.all
  end
  
  def show
    @digital_asset = DigitalAsset.find(params[:id])
  end
  
  def new
    @digital_asset = DigitalAsset.new
  end
  
  def create
    @digital_asset = DigitalAsset.new(params[:digital_asset])
    if @digital_asset.save
      flash[:notice] = "Successfully created digital_asset."
      redirect_to @digital_asset
    else
      render :action => 'new'
    end
  end
  
  def edit
    @digital_asset = DigitalAsset.find(params[:id])
  end
  
  def update
    @digital_asset = DigitalAsset.find(params[:id])
    if @digital_asset.update_attributes(params[:digital_asset])
      flash[:notice] = "Successfully updated digital_asset."
      redirect_to @digital_asset
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @digital_asset = DigitalAsset.find(params[:id])
    @digital_asset.destroy
    flash[:notice] = "Successfully destroyed digital_asset."
    redirect_to digital_assets_url
  end
end
