class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode, if: -> (user){ user.latitude.present? and user.latitude_changed? and user.longitude.present? and user.longitude_changed? }
end
