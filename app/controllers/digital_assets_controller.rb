class DigitalAssetsController < ApplicationController
    
  def index
    @digital_assets = DigitalAsset.all.paginate(:page=>params[:page], :per_page=>52, :include=>"items", :order=>"items.alphabetical_title, scan_file_name")
  end
  
  def show
    @digital_asset = DigitalAsset.find(params[:id])
    
  end
  
  def new
    @digital_asset = DigitalAsset.new
  end
  
  def create
    digital_asset_subject_ids = params[:digital_asset][:digital_asset_subject_ids]
    params[:digital_asset].delete(:digital_asset_subject_ids)
    @digital_asset = DigitalAsset.new(params[:digital_asset])
    if @digital_asset.save
      unless @digital_asset.digital_asset_subjects.nil?
        digital_asset_subject_ids << @digital_asset.digital_asset_subjects.first.id
      end
      @digital_asset.update_attribute(:digital_asset_subject_ids, digital_asset_subject_ids)
      flash[:notice] = "Successfully created digital_asset."
      redirect_to @digital_asset
    else
      render :action => 'new'
    end
  end
  
  def most_recent
    ActiveRecord::Base.include_root_in_json = false
    @digital_assets = DigitalAsset.most_recent
    respond_to do |wants|
      wants.html {   }
      wants.xml { render :xml=>@digital_assets.to_xml }
      wants.json {render :json=>@digital_assets.to_json(:only=>[:id], :methods=>:mini_url ) }
    end   
  end
  
  def edit
    @digital_asset = DigitalAsset.find(params[:id], :include=>[:digital_asset_subjects])
  end
  
  def update
    digital_asset_subject_ids = params[:digital_asset][:digital_asset_subject_ids]
    params[:digital_asset].delete(:digital_asset_subject_ids)
    @digital_asset = DigitalAsset.find(params[:id])
    @digital_asset.update_attribute(:digital_asset_subject_ids, digital_asset_subject_ids)
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
