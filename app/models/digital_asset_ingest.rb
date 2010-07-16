class DigitalAssetIngest < ActiveRecord::Base
  
  # add a has_and_belongs_to_many through for items to keep track of which items it ingested images for each time.
  
  def process_digital_assets
     # get a list of all of the images in the DIGITAL_ASSET_UPLOADS folder
    file_list = Dir.glob(DIGITAL_ASSET_UPLOADS_DIR + "/*.*")
    
     # if there are no images found, create a status of "no images found" and exit
    if file_list.size == 0 
      self.status = "No new files found"
       
    else    # if there are new images found, process them
      
      # each image will be prefixed with the id or legacy id of an item 
      # so, get a list of all the unique prefixes in the folder
      
      prefixes = unique_prefixes(file_list)     
      self.status = "New images have been found"
      
    end
    
    self.status = "Adding images"
    prefixes.each do |prefix|
      # for each prefix, check to see if you can find the image by id
      item = Item.find_by_id(prefix)
      # if not, try the legacy id
      item ||= Item.find_by_legacy_id(prefix)
      if item.nil?  # if you don't find a matching item then put the images into a reject folder
        move_to_reject_folder(prefix)
      else  # if you do find one then match and delete all the images
        match_and_delete(item,prefix)
      end
      
    end
    
  end

  private
  
  def match_and_delete(item, prefix)
    
    file_list = Dir.glob(DIGITAL_ASSET_UPLOADS_DIR + "/#{prefix}*.*")
    puts file_list
    file_list.each do |filename|
      file = File.open(filename)
      asset = DigitalAsset.new
      asset.scan = file
      asset.save!
      item.digital_assets << asset
      File.delete(filename)
    end
    
  end
  
  def move_to_reject_folder(prefix)
    FileUtils.mkdir_p(DIGITAL_ASSET_UPLOADS_DIR + "/rejects/")
    file_list = Dir.glob(DIGITAL_ASSET_UPLOADS_DIR + "/#{prefix}*.*")
    file_list.each do |filename|
      # File.move doesn't exist
      FileUtils.move(filename, DIGITAL_ASSET_UPLOADS_DIR + "/rejects/")
    end
    
  end
  
  def unique_prefixes(dir_list)
    
    prefixes = []
    dir_list.each do |filename|
      name = File.basename(filename)
      prefix, suffix  = name.split("_")
      prefixes << prefix
    end
    
    return prefixes.uniq

  end

  
end
