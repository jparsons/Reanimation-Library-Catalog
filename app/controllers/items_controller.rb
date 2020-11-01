class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:recent]
  before_action :cataloger_required, :only=>[:new, :edit]
  before_action :handle_new_subjects, only: [:update]

  def index
    letter = params[:letter] || "1-9"
    if user_signed_in? && current_user.is_administrator?
      if letter == "1-9"
        @items = Item.non_alphanumerical
      else
        @items = Item.starting_with letter
      end
    else
      if letter == "1-9"
        @items = Item.non_alphanumerical.published
      else
        @items = Item.starting_with(letter).published
      end
    end
    @items = @items.includes(:subjects, creators: :creator_type )
  end

  def by_branch
    @branches = Item.where("acquired_for is not null AND acquired_for != ''").map(&:acquired_for).uniq.sort
    @branch = params[:branch] || @branches.first
    @items = Item.where(:acquired_for => @branch).order(:alphabetical_title)
  end

  def by_call_number
    @items = Item.by_call_number.published.paginate(:page => params[:page], :per_page => 20).includes(creators: :creator_type ).includes(:subjects)
  end

  def acquired
    unless params[:sort_by].blank?
      order = "#{params[:sort_by]} #{params[:sort_order] || 'ASC'}"
    else
      order = "call_number ASC"
    end
    @items = Item.need_cataloging.all.order(order)
  end

  def need_images
    unless params[:sort_by].blank?
      order = "#{params[:sort_by]} #{params[:sort_order] || 'ASC'}"
    else
      order = "call_number ASC"
    end
    @items = Item.no_assets(order)
  end

  def process_images
    d = DigitalAssetIngest.new
    d.process_digital_assets
  end

  def recent
    ActiveRecord::Base.include_root_in_json = false
    respond_to do |wants|
      wants.html { @items = Item.published.order("created_at desc").paginate( :page => params[:page]) }
      wants.xml {
        @items = Item.published.order("created_at desc").paginate( :page => params[:page]).includes(creators: :creator_type ).includes(:subjects)
        render :xml=>@items.to_xml
        }
      wants.json { render_json Item.recent.map{|i| {id: i.id, display_title: i.display_title.force_encoding('utf-8'), display_title_with_colon: i.display_title_with_colon.force_encoding('utf-8'), display_creator: i.display_creator}}.to_json }
      #wants.json {render_json Item.recent.to_json(:only=>[:id], :methods=>[:display_title, :display_title_with_colon, :display_creator]) }
    end
  end
  #  add item_count api

  def show
    @item = Item.find_by_id(params[:id])
    if @item.blank? || (@item.unpublished? && !authorized_user)
      not_found
    end
    @previous = Item.previous(@item).first
    @next = Item.next(@item).first
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "Successfully created item."
      redirect_to @item
    else
      render :action => 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])

  end




  def update
    # I'm not sure why I have to pull out subject_id here, but it wouldn't work otherwise
    # Donors seems to be configured in an identical way, but it works through the normal accepts_nested_attributes
    # functionality


    #subject_ids = params[:item][:subject_ids]
    #params[:item].delete(:subject_ids)

    @item = Item.find(params[:id])
    if params[:commit] == PUBLISH_TEXT || params[:commit] == SHORT_PUBLISH_TEXT
      @item.cataloging_status = "published"
      @item.published_at = Time.now
    elsif params[:commit] == UNPUBLISH_TEXT || params[:commit] == SHORT_UNPUBLISH_TEXT
      @item.cataloging_status = "unpublished"
    end
    params[:item][:price_paid] = params[:item][:price_paid].sub(/\$/, "").to_f if (params && params[:item])
   # @item.update_attribute(:subject_ids, subject_ids)
    if @item.update_attributes(item_params)
      @new_subjects.each do |k,v|
        subject = Subject.find_by(name: v['name'])
        if subject
          @item.subjects << subject
        else
          subject = Subject.create(name: v['name'], authority: v['authority'])
          @item.subjects << subject
        end
      end
      flash[:notice] = "Successfully updated item."
      redirect_to @item
    else
      render :action => 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = "Successfully destroyed item."
    redirect_to items_url
  end

  # def cataloger_required
  #   user_signed_in? && (current_user.is_administrator? || current_user.is_cataloger?)
  # end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  private

  def handle_new_subjects
    if params[:item][:subjects_attributes]
      @new_subjects = params[:item][:subjects_attributes].select{|k,v| v['id'].nil?}
      params[:item][:subjects_attributes].reject!{|k,v| v['id'].nil?}
    else
      @new_subjects = []
    end
  end

  def item_params
    params.require(:item).permit(
      :title,
      :subtitle,
      :publisher_name,
      :publisher_city,
      :publisher_state,
      :publisher_country,
      :extent,
      :copyright,
      :item_size,
      :call_number,
      :collection_name,
      :legacy_id,
      :cover_image_file_name,
      :cover_image_cache,
      :barcode,
      :has_marc_record,
      :metadata_notes,
      :corporate_author,
      :isbn_issn,
      :is_government_document,
      :edition,
      :notes,
      :series_name,
      :needs_translation,
      :location,
      :is_marked,
      :vendor_id,
      :date_acquired,
      :price_paid,
      :acquisition_type,
      :acquisition_note,
      :acquired_for,
      :legacy_record_id,
      :cataloging_status,
      :provenance,
      :dedication,
      :inscription,
      :physical_format,
      :published_at,
      :cover_image,
      donor_ids: [],
      image_color_ids: [],
      language_ids: [],
      image_type_ids: [],
      subjects_attributes: [:id, :name, :authority, :_destroy],
      donors_attributes: [:id, :name, :organization_name, :_destroy],
      vendor_attributes: [:id, :name, :street, :city, :state, :zip, :country, :url, :_destroy],
      creators_attributes: [:id, :first_name, :last_name, :middle_name, :name_suffix, :creator_type_id, :_destroy],
    )
  end
end
