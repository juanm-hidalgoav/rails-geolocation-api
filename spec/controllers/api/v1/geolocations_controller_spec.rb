require 'rails_helper'

RSpec.describe Api::V1::GeolocationsController, type: :controller do
  let(:user) { create(:user) }
  let(:api_key) { create(:api_key, user: user, expires_at: 1.day.from_now) }

  before do
    request.headers['Authorization'] = "Bearer #{api_key.key}"
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
  describe 'POST /geolocations' do
    it 'creates a geolocation with valid data' do
      strategy = double('IpstackService', fetch_geolocation: {
        'country_code' => 'CA',
        'region_name' => 'Ontario',
        'city' => 'Kingston',
        'latitude' => 44.22967,
        'longitude' => -76.47993
      })

      allow(GeolocationService).to receive(:new).and_return(GeolocationService.new(strategy))

      post :create, params: {
        geolocation: {
          ip_or_url: '76.67.111.217'
        }
      }

      puts response.body if response.status == 422
      
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['city']).to eq('Kingston')
    end
  end
end
