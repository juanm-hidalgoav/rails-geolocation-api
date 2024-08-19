class Country < ApplicationRecord
    has_many :regions
    has_many :geolocations
  
    validates :code, presence: true, uniqueness: true
    validates :name, presence: true
  end