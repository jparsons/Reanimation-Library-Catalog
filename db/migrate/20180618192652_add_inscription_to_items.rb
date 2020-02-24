class AddInscriptionToItems < ActiveRecord::Migration[4.2]
  def change
    add_column :items, :inscription, :text
  end
end
