class AddCoverImageToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :cover_image, :string
  end
end
