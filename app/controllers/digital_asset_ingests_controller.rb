class DigitalAssetIngestsController < ApplicationController

  
  def index
    @ingests = DigitalAssetIngest.all
  end
  
  def create
    ingest = DigitalAssetIngest.new
    ingest.process_digital_assets
    redirect_to digital_asset_ingests_url
  end
 
end