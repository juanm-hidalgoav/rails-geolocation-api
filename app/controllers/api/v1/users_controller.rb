module Api
  module V1
    class Api::V1::UsersController < Api::V1::BaseController
      before_action :authenticate_with_api_key, only: [:destroy]

      def index
        @users = User.all
        render json: @users
      end

      def show
        @user = User.find(params[:id])
        render json: @user
      end

      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user = User.find(params[:id])
        @user.destroy
        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:email, :encrypted_password)
      end
    end
  end
end