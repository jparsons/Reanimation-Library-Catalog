class ItemsController < ApplicationController

 before_filter :only=>[:new, :edit] do |c| c.send(:require_role, :administrator)  end
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
  
  def acquired 
    unless params[:sort_by].blank?
      order = "#{params[:sort_by]} #{params[:sort_order] || 'ASC'}"
    else 
      order = "call_number ASC"
    end
    @items = Item.acquired.all(:order => order)
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
    @items = Item.published.recent
    respond_to do |wants|
      wants.html {   }
      wants.xml { render :xml=>@items.to_xml }
      wants.json {render :json=>@items.to_json(:only=>[:id], :methods=>[:display_title, :display_creator]) }
    end
  end

  def show
    @item = Item.find(params[:id])
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
    if params[:commit] == PUBLISH_TEXT
      @item.cataloging_status = "published"
    elsif params[:commit] == UNPUBLISH_TEXT
      @item.cataloging_status = "private"
    end
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
end
