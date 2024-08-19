class Region < ApplicationRecord
    belongs_to :country
    has_many :geolocations
  
    validates :name, presence: true
  end