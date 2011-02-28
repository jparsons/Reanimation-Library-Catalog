class SearchController < ApplicationController
  def new
    if params[:q]
       @query = params[:q]
    else
       query_parts = []
       unless params[:title].blank?
         query_parts << "display_title:(#{params[:title]})"
       end
       unless params[:subjects].blank?
         query_parts << "subject_list:(#{params[:subjects]})"
       end
       unless params[:creators].blank?
         query_parts << "display_creator:(#{params[:creators]})"
       end
      @query = query_parts.join(" AND ")
    end
    @items = Item.search(@query)
  end


end
