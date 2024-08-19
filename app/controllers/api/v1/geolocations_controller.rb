module Api
  module V1
    class Api::V1::GeolocationsController < Api::V1::BaseController
      before_action :authenticate_with_api_key, only: [:create, :destroy]

      def index
        @geolocations = Geolocation.all
        render json: @geolocations
      end

      def show
        @geolocation = Geolocation.find(params[:id])
        render json: @geolocation
      end

      def lookup_by_ip
        geolocation = Geolocation.find_by(ip_or_url: params[:ip_or_url])

        if geolocation
          render json: geolocation, status: :ok
        else
          render json: { error: 'Geolocation data not found' }, status: :not_found
        end
      end
      
      def create
        geolocation_service = GeolocationService.new
        # geolocation_service = GeolocationService.new(MaxMindService.new)
        geolocation_data = geolocation_service.get_geolocation(geolocation_params[:ip_or_url])
        
        if geolocation_data

          country = Country.find_by(code: geolocation_data['country_code'])
  
          if country.nil?
            render json: { error: "Country with code #{geolocation_data['country_code']} not found" }, status: :unprocessable_entity
            return
          end

          region = Region.find_by(name: geolocation_data['region_name'])
  
          if country.nil?
            render json: { error: "Region with name #{geolocation_data['region_name']} not found" }, status: :unprocessable_entity
            return
          end

          @geolocation = Geolocation.new(
            ip_or_url: geolocation_params[:ip_or_url],
            country: country,
            region: region,
            city: geolocation_data['city'],
            latitude: geolocation_data['latitude'],
            longitude: geolocation_data['longitude'],
            api_key: @current_api_key
          )

          if @geolocation.save
            render json: @geolocation, status: :created
          else
            render json: @geolocation.errors, status: :unprocessable_entity
          end
        else
          render json: { error: 'Failed to fetch geolocation data' }, status: :unprocessable_entity
        end
      end

      def destroy
        @geolocation = Geolocation.find(params[:id])
        @geolocation.destroy
        head :no_content
      end

      private

      def geolocation_params
        params.require(:geolocation).permit(:ip_or_url)
      end
    end
  end
end