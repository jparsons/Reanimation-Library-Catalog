class WorksController < ApplicationController
  
  before_filter do |c| c.send(:require_group, CATALOGER_ROLES) end
  
  def index
    
    @works = Work.all.paginate(:page=>params[:page], :per_page=>20, :include=>:work_creators)
  end
  
  def show
    @work = Work.find(params[:id])
  end
  
  def new
    @work = Work.new
    5.times { @work.work_images.build }
  end
  
  def create
    #work_creator_ids = params[:work][:work_creator_ids]
    #params[:work].delete(:work_creator_ids)
    
    @work = Work.new(params[:work])
    if @work.save
      #work_creator_ids += @work.work_creator_ids
      #logger.debug work_creator_ids
      #logger.debug work_creator_ids.uniq
      
      #@work.update_attribute(:work_creator_ids, work_creator_ids.uniq)
      flash[:notice] = "Successfully created work."
      redirect_to @work
    else
      render :action => 'new'
    end
  end
  
  def edit
    @work = Work.find(params[:id], :include=>[:items])

  end
  
  def update
    params[:work][:item_ids] ||= []  
    
    @work = Work.find(params[:id])
    if @work.update_attributes(params[:work])
      flash[:notice] = "Successfully updated work."
      redirect_to @work
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @work = Work.find(params[:id])
    @work.destroy
    flash[:notice] = "Successfully destroyed work."
    redirect_to works_url
  end
end
