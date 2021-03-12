class Event < ApplicationRecord
  belongs_to :user
  geocoded_by :address
  has_one_attached :photo
  has_many :bookings, dependent: :destroy
  after_validation :geocode, if: :will_save_change_to_address?
  validates :name, :date_time_start, :date_time_end, :address, presence: :true
end
