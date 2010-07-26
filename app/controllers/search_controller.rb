class SearchController < ApplicationController
  def new
  end

  def show
    @items = Item.search(params)
  end

end
