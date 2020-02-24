class SubjectsController < ApplicationController
  def index
    @subjects = Subject.order(:name).paginate(:page=>params[:page])
  end

  def show
    @subject = Subject.includes(:items).find(params[:id])
  end

end
