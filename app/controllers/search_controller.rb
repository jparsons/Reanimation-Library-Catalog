class SearchController < ApplicationController
  def new
    @items = Item.search(params)
  end

  def show
    @items = Item.search(params)
  end

end
