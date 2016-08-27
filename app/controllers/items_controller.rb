class ItemsController < ApplicationController

  before_filter :cataloger_required, :only=>[:new, :edit]
  def index
    letter = params[:letter] || "1-9"
    if logged_in? && current_user.is_administrator?
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

  end

  def by_branch
    @branches = Item.where("acquired_for is not null AND acquired_for != ''").map(&:acquired_for).uniq.sort
    @branch = params[:branch] || @branches.first
    @items = Item.where(:acquired_for => @branch).order(:alphabetical_title)
  end

  def by_call_number
    @items = Item.by_call_number.published.paginate(:page => params[:page], :per_page => 20)
  end

  def acquired
    unless params[:sort_by].blank?
      order = "#{params[:sort_by]} #{params[:sort_order] || 'ASC'}"
    else
      order = "call_number ASC"
    end
    @items = Item.need_cataloging.all(:order => order)
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
        @items = Item.published.order("created_at desc").paginate( :page => params[:page])
        render :xml=>@items.to_xml
        }
      wants.json {render_json Item.recent.to_json(:only=>[:id], :methods=>[:display_title, :display_title_with_colon, :display_creator]) }
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
    @item = Item.new(params[:item])
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
    if @item.update_attributes(params[:item])
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
  #   logged_in? && (current_user.is_administrator? || current_user.is_cataloger?)
  # end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
