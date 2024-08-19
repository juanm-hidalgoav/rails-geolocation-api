module Api
  module V1
    class Api::V1::ApiKeysController < Api::V1::BaseController
      before_action :authenticate_with_api_key, only: [:create, :destroy]

      def index
        @api_keys = ApiKey.all
        render json: @api_keys
      end 

      def create
        @api_key = ApiKey.new(api_key_params)
        @api_key.user = @current_user

        if @api_key.save
          render json: @api_key, status: :created
        else
          render json: @api_key.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @api_key = ApiKey.find(params[:id])
        @api_key.destroy
        head :no_content
      end

      private

      def api_key_params
        params.require(:api_key).permit(:user_id, :expires_at, :scopes, :description)
      end
    end
  end
end