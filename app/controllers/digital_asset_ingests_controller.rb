class DigitalAssetIngestsController < ApplicationController
  
  before_filter do |c| c.send(:require_group, CATALOGER_ROLES) end

  
  def index
    @digital_asset_ingest = DigitalAssetIngest.new
    @digital_asset_ingests = DigitalAssetIngest.all.paginate(:page=>params[:page], :per_page=>10)
  end
  
  
  def create
    ingest = DigitalAssetIngest.create!(:start_time=>Time.now(), :status=>"In progress")

    ingest.process_log = ProcessLog.create!
    ingest.send_later(:process_digital_assets)
    #ingest.process_log.update_attribute(:end_time=>Time.now())
    #ingest.save!
    #BatchImporter.new(Shop.find(1)).send_later(:import_massive_csv, massive_csv)
    redirect_to digital_asset_ingest_path(ingest)
  end
  
  def show
    @ingest = DigitalAssetIngest.find(params[:id], :include=>[:process_log])
    
  end
 
end