class ApplicationController < ActionController::API
    private
  
    def authenticate_with_api_key
      api_key = request.headers['Authorization']&.split(' ')&.last
      @current_api_key = ApiKey.find_by(key: api_key)
  
      if @current_api_key.nil? || @current_api_key.revoked_at.present? || (@current_api_key.expires_at && @current_api_key.expires_at < Time.now)
        render json: { error: 'Unauthorized' }, status: :unauthorized
      else
        @current_user = @current_api_key.user
      end
    end
end
