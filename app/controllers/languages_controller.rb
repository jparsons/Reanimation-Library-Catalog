class LanguagesController < ApplicationController

  def index
    @languages = Language.all
  end

    def edit
    @language = Language.find(params[:id])
  end

  def update
    @language = Language.find(params[:id])
    if @language.update_attributes(language_params)
      flash[:notice] = 'Language was successfully created.'
      redirect_to languages_path
    else
      render :action => :edit
    end
  end

  def new
    @language = Language.new
  end

  def create
    @language = Language.new(language_params)
    if @language.save
      flash[:notice] = 'languages_path was successfully created.'
      redirect_to languages_path
    else
      render :action => :new
    end
  end

  def destroy
    @language = Language.find(params[:id])
    @language.destroy

    respond_to do |format|
      format.html { redirect_to(languages_path) }
      format.xml  { head :ok }
    end
  end

  private

  def language_params
    params.require(:language).permit(
      :id,
      :name
    )
  end

end
