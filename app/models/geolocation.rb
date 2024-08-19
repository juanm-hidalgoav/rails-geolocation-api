class Geolocation < ApplicationRecord
  belongs_to :country
  belongs_to :region, optional: true
  belongs_to :api_key

  validates :ip_or_url, presence: true, uniqueness: true
  validates :latitude, numericality: true, allow_nil: true
  validates :longitude, numericality: true, allow_nil: true
end