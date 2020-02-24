class DigitalAssetIngest < ActiveRecord::Base
  default_scope {order("created_at desc") }
  has_one :process_log

  def has_images_to_process?
     file_list = Dir.glob(DIGITAL_ASSET_UPLOADS_DIR + "/*.*")
     return file_list.size > 0
  end

  def process_digital_assets
     # get a list of all of the images in the DIGITAL_ASSET_UPLOADS folder
    file_list = Dir.glob(DIGITAL_ASSET_UPLOADS_DIR + "/*.*")
     # if there are no images found, create a status of "no images found" and exit
    if file_list.size < 1
      process_log.log_entries << LogEntry.create!(:message=>"No new files found")
    else    # if there are new images found, process them
      process_log.log_entries << LogEntry.create(:message=>"Found #{file_list.size.to_s} new files")
      # each image will be prefixed with the id or legacy id of an item
      # so, get a list of all the unique prefixes in the folder

      prefixes = unique_prefixes(file_list)


      prefixes.each do |prefix|
        # for each prefix, check to see if you can find the image by id
        item = Item.find_by(id: prefix)
        # if not, try the legacy id
        if item.nil?  # if you don't find a matching item then put the images into a reject folder
          move_to_reject_folder(prefix)
        else  # if you do find one then match and delete all the images
          match_and_delete(item,prefix)
        end
      end
    end

    self.status = "Complete"
    self.end_time = Time.now()
    self.save!

  end

  def process_cover_images
    file_list = Dir.glob(File.join(COVER_IMAGE_UPLOADS_DIR, "*.*"))
    file_list.each do |filename|
      prefix, suffix = File.basename(filename).scan(/([0-9]*)(.*)/).flatten
      item = Item.find_by_id(prefix)
      if item
        item.cover_image = File.open(filename)
        item.save!
        #File.delete(filename)
        FileUtils.move(filename, File.join(COVER_IMAGE_UPLOADS_DIR, "deletes"))
      else
        FileUtils.move(filename, File.join(COVER_IMAGE_UPLOADS_DIR, "rejects"))
      end
    end


  end

  private

  def match_and_delete(item, prefix)

    file_list = Dir.glob(DIGITAL_ASSET_UPLOADS_DIR + "/#{prefix}*.*")
    # puts file_list
    file_list.each do |filename|
      file = File.open(filename)
      asset = DigitalAsset.find_or_create_by(scan_file_name: filename)
      asset.scan = file
      asset.save!
      item.digital_assets << asset
      File.delete(filename)
      process_log.log_entries << LogEntry.new(:message=>"Matched #{filename} with #{item.display_title}")
      #FileUtils.move(filename, DIGITAL_ASSET_UPLOADS_DIR + "/deletes/")

    end

  end

  def move_to_reject_folder(prefix)
    FileUtils.mkdir_p(DIGITAL_ASSET_UPLOADS_DIR + "/rejects/")
    file_list = Dir.glob(DIGITAL_ASSET_UPLOADS_DIR + "/#{prefix}*.*")
    file_list.each do |filename|

      process_log.log_entries << LogEntry.new(:message=>"Could not find a match for #{filename}. It has been moved to the rejects folder")
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


# == Schema Information
#
# Table name: digital_asset_ingests
#
#  id         :integer         not null, primary key
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#  start_time :datetime
#  end_time   :datetime
#
