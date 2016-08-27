class LanguagesController << ApplicationController

  def index
    @languages = Language.all
  end

    def edit
    @language = Language.find(params[:id])
  end

  def update
    @language = Language.find(params[:id])
    if @language.update_attributes(params[:language])
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
    @language = Language.new(params[:language])
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

end