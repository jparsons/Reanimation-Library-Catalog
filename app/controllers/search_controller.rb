class SearchController < ApplicationController
  def new
    if params[:q].blank?
      @items = []
    else
      @items = Item.search(params)
    end
  end

  def show
    @items = Item.search(params)
  end

end
