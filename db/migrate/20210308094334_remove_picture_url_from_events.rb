class RemovePictureUrlFromEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :picture_url, :string
  end
end
