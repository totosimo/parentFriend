class AddUrlToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :picture_url, :string
  end
end
