module Api
  module V1
    class Api::V1::BaseController < ApplicationController
      # Common error handling methods for the API controllers

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
      rescue_from ActionController::ParameterMissing, with: :bad_request

      private

      def record_not_found(error)
        render json: { status: 'error', message: error.message, code: 404 }, status: :not_found
      end

      def unprocessable_entity(error)
        render json: { status: 'error', message: error.record.errors.full_messages.join(', '), code: 422 }, status: :unprocessable_entity
      end

      def bad_request(error)
        render json: { status: 'error', message: error.message, code: 400 }, status: :bad_request
      end

      def unauthorized_request(error)
        render json: { status: 'error', message: 'Unauthorized access', code: 401 }, status: :unauthorized
      end

      def forbidden_request(error)
        render json: { status: 'error', message: 'Forbidden access', code: 403 }, status: :forbidden
      end
    end
  end
end