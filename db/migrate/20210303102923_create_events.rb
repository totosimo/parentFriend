class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.float :latitude
      t.float :longitude
      t.datetime :date_time_start
      t.datetime :date_time_end
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
