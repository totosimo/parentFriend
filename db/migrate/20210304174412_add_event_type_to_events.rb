class AddEventTypeToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :event_type, :string
  end
end
