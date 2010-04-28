class CreatorsController < ApplicationController
  def index
    @creators = Creator.all
  end
  
  def show
    @creator = Creator.find(params[:id])
  end
  
  def new
    @creator = Creator.new
  end
  
  def create
    @creator = Creator.new(params[:creator])
    if @creator.save
      flash[:notice] = "Successfully created creator."
      redirect_to @creator
    else
      render :action => 'new'
    end
  end
  
  def edit
    @creator = Creator.find(params[:id])
  end
  
  def update
    @creator = Creator.find(params[:id])
    if @creator.update_attributes(params[:creator])
      flash[:notice] = "Successfully updated creator."
      redirect_to @creator
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @creator = Creator.find(params[:id])
    @creator.destroy
    flash[:notice] = "Successfully destroyed creator."
    redirect_to creators_url
  end
end
