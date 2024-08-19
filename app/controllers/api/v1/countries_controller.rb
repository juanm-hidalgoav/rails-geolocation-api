module Api
    module V1
      class Api::V1::CountriesController < Api::V1::BaseController
        def index
          @countries = Country.all
          render json: @countries
        end
  
        def show
          @country = Country.find(params[:id])
          render json: @country
        end
      end
    end
  end