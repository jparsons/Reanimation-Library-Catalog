class AddInscriptionToItems < ActiveRecord::Migration
  def change
    add_column :items, :inscription, :text
  end
end
