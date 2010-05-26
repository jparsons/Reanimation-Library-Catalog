class RenameVolumeIdentiferToIdentifierInSeriesParts < ActiveRecord::Migration
  def self.up
    rename_column :series_parts, :volume_identifer, :volume_identifier
  end

  def self.down
    rename_column :series_parts, :volume_identifier, :volume_identifer

  end
end
