class SubjectsController < ApplicationController
  def index
    @subjects = Subject.order(:name).paginate(:page=>params[:page])
  end
  
  def show
    @subject = Subject.find(params[:id], :include=>[:items])
  end

end
