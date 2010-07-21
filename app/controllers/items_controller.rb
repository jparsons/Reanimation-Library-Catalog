class ItemsController < ApplicationController

  #before_filter :admin_required, :only => [:new, :edit, :create, :update, :destroy]
  
  def index
    letter = params[:letter] || "1-9"
    if letter == "1-9"
      @items = Item.non_alphanumerical
    else
      @items = Item.starting_with letter
    end

  end
  
  def acquired 
    @items = Item.acquired
    render :layout=>"admin"
  end
  
  def need_images
    @items = Item.no_assets
    render :layout=>"admin"
  end
  
  def process_images
    d = DigitalAssetIngest.new
    d.process_digital_assets
    render :layout=>"admin"
  end
  
  def show
    @item = Item.find(params[:id])
    @previous = Item.previous(@item).first
    @next = Item.next(@item).first
  end
  
  def new
    @item = Item.new
    render :layout => "admin"
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
    render :layout=> "admin"
  end
  
  def update
    # I'm not sure why I have to pull out subject_id here, but it wouldn't work otherwise
    # Donors seems to be configured in an identical way, but it works through the normal accepts_nested_attributes 
    # functionality
    
    subject_ids = params[:item][:subject_ids]
    params[:item].delete(:subject_ids)
    @item = Item.find(params[:id])
    @item.update_attribute(:subject_ids, subject_ids)
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
