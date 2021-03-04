class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :tagline
      t.text :description
      t.float :geo_long
      t.float :geo_lat
      t.datetime :datetime_start
      t.datetime :datetime_end
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
