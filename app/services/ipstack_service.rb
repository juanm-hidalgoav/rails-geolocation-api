require 'net/http'
require 'json'

class IpstackService
  BASE_URL = 'http://api.ipstack.com/'.freeze

  def initialize(api_key = ENV['IPSTACK_API_KEY'])
    @api_key = api_key
  end

  def fetch_geolocation(ip_or_url)
    url = URI("#{BASE_URL}#{ip_or_url}?access_key=#{@api_key}")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    if data['success'] == false
      Rails.logger.error("Geolocation API Error: #{data['error']['info']}")
      return nil
    end

    data
    rescue JSON::ParserError => e
      Rails.logger.error("Failed to parse geolocation data: #{e.message}")
      nil
    rescue StandardError => e
      Rails.logger.error("Failed to fetch geolocation data: #{e.message}")
      nil
  end
end