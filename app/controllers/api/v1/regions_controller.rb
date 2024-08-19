module Api
    module V1
      class Api::V1::RegionsController < Api::V1::BaseController
        def index
          @regions = Region.all
          render json: @regions
        end
  
        def show
          @region = Region.find(params[:id])
          render json: @region
        end
      end
    end
  end