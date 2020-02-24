class DigitalAssetsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:most_recent]

  def index
    @digital_assets = DigitalAsset.published.by_scan_file_name.paginate(:page=>params[:page], :per_page=>52).includes(:item).order("items.alphabetical_title, scan_file_name")
  end

  def show
    @digital_asset = DigitalAsset.find(params[:id])
    @previous = @digital_asset.previous().first
    @next = @digital_asset.next().first
    if user_signed_in? && (current_user.is_administrator? || current_user.is_cataloger?)
      @tags = ActsAsTaggableOn::Tag.all.map(&:name)
    end
  end

  def new
    @digital_asset = DigitalAsset.new
    @digital_asset.item_id = params[:item_id] if params[:item_id]
  end

  def create
    @digital_asset = DigitalAsset.new(digital_asset_params)
    if @digital_asset.save
      flash[:notice] = "Image was added successfully. Would you like to add another?"
      redirect_to new_digital_asset_path(:item_id => @digital_asset.item_id)
    else
      render :action => 'new'
    end
  end

  def most_recent
    ActiveRecord::Base.include_root_in_json = false
    @digital_assets = DigitalAsset.published.most_recent
    respond_to do |wants|
      wants.html {   }
      wants.xml { render :xml=>@digital_assets.to_xml }
      wants.json {render json: @digital_assets.to_json(:only=>[:id], :methods=>:mini_url ) }
    end
  end

  def edit
    @digital_asset = DigitalAsset.includes(:digital_asset_subjects).find(params[:id])
    @tags = ActsAsTaggableOn::Tag.all.map(&:name)
  end

  def update
    @digital_asset = DigitalAsset.find(params[:id])
    if @digital_asset.update_attributes(digital_asset_params)
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

  def tag_cloud
    @tags = Post.tag_counts_on(:tags)
  end

  def tag
    @tag = params[:id]
    @digital_assets = DigitalAsset.tagged_with(@tag).paginate(:page=>params[:page], :per_page=>52, :includes=>"items", :order=>"items.alphabetical_title, scan_file_name")
    if user_signed_in? && (current_user.is_administrator? || current_user.is_cataloger?)
      @tags = ActsAsTaggableOn::Tag.all.map(&:name)
    end

    render :index
  end

  private

  def digital_asset_params
    params.require(:digital_asset).permit(
      :item_id,
      :color,
      :tag_list,
      :scan,
      :scan_file_name,
      :scan_cache,
      digital_asset_subject_ids: [],
      digital_asset_subjects_attributes: [:name, :authority]
    )
  end
end
