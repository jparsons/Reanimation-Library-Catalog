class SeriesPart < ActiveRecord::Base
  belongs_to :series
  belongs_to :item
end
