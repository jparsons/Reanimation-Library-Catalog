class SearchController < ApplicationController
  def new
    if params[:q]
       @query = params[:q]
    else
       query_parts = []
       unless params[:id].blank?
         query_parts << "item_id:(#{params[:id]})"
       end
       unless params[:title].blank?
         query_parts << "display_title:(#{params[:title]})"
       end
       unless params[:subjects].blank?
         query_parts << "subject_list:(#{params[:subjects]})"
       end
       unless params[:creators].blank?
         query_parts << "display_creator:(#{params[:creators]})"
       end
       unless params[:copyright].blank?
         query_parts << "copyright:(#{params[:copyright]})"
       end
       unless params[:image_colors].blank?
         query_parts << "copyright:(#{params[:image_colors]})"
       end
       unless params[:image_types].blank?
         query_parts << "image_types:(#{params[:image_types]})"
       end
       unless params[:is_public_domain].blank?
         query_parts << "is_public_domain:(#{params[:is_public_domain]})"
       end
       unless params[:collection_name].blank?
         query_parts << "collection_name:(#{params[:collection_name]})"
       end
       @query = query_parts.join(" AND ")
    end
    @items = Item.search(@query, logged_in?)
  end


end
