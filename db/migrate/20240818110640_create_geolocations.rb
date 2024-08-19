class CreateGeolocations < ActiveRecord::Migration[7.0]
  def change
    create_table :geolocations do |t|
      t.string :ip_or_url, null: false, unique: true
      t.references :country, null: false, foreign_key: true
      t.references :region, foreign_key: true
      t.references :api_key, null: false, foreign_key: true
      t.string :city
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end