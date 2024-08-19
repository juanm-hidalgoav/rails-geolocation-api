class GeolocationService
  def initialize(strategy = IpstackService.new)
    @strategy = strategy
  end

  def get_geolocation(ip_or_url)
    @strategy.fetch_geolocation(ip_or_url)
  end
end