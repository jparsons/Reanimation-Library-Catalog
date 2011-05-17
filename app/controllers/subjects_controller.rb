class SubjectsController < ApplicationController
  def index
    @subjects = Subject.all.paginate(:page=>params[:page], :order=>'name')
  end
  
  def show
    @subject = Subject.find(params[:id], :include=>[:items])
  end

end
