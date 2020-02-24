class WorksController < ApplicationController

  before_action do |c| c.send(:require_group, CATALOGER_ROLES) end

  def index

    @works = Work.all.paginate(:page=>params[:page], :per_page=>20, :include=>:work_creators)
  end

  def show
    @work = Work.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    #work_creator_ids = work_params[:work_creator_ids]
    #work_params.delete(:work_creator_ids)

    @work = Work.new(work_params)
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
    @work = Work.includes(:items).find(params[:id])

  end

  def update
    params[:work][:item_ids] ||= []

    @work = Work.find(params[:id])
    if @work.update_attributes(work_params)
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

  private

  def work_params
    params.require(:work).permit(
      :title,
      :medium,
      :size,
      :year_created,
      :work_type,
      work_creator_ids: [],
      item_ids: [],
      work_creators_attributes: [ :name ],
      work_images_attributes: [ :image ]
    )
  end
end
