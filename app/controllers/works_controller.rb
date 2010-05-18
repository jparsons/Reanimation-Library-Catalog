class WorksController < ApplicationController
  def index
    @works = Work.all
  end
  
  def show
    @work = Work.find(params[:id])
  end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(params[:work])
    if @work.save
      flash[:notice] = "Successfully created work."
      redirect_to @work
    else
      render :action => 'new'
    end
  end
  
  def edit
    @work = Work.find(params[:id])
  end
  
  def update
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
