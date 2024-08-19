require 'rails_helper'

RSpec.describe GeolocationService, type: :service do
  describe '#get_geolocation' do
    it 'delegates geolocation fetching to the strategy' do
      strategy = double('IpstackService')
      expect(strategy).to receive(:fetch_geolocation).with('76.67.111.207')
      service = GeolocationService.new(strategy)
      service.get_geolocation('76.67.111.207')
    end
  end
end