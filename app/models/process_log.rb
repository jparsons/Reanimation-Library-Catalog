class ProcessLog < ActiveRecord::Base
  belongs_to :digital_asset_ingest
  has_many :log_entries
end
