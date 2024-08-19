require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let!(:user) { create(:user, email: 'test@example.com', encrypted_password: '2r4f4rgr45yr7464g35uyteg324') }

  describe 'GET #index' do
    before { get :index }

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a list of users' do
      expect(JSON.parse(response.body).length).to eq(2)
    end
  end

  describe 'GET #show' do
    context 'when the user exists' do
      before { get :show, params: { id: user.id } }

      it 'returns a success response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the correct user' do
        expect(JSON.parse(response.body)['id']).to eq(user.id)
      end
    end

    context 'when the user does not exist' do
      before { get :show, params: { id: 999 } }

      it 'returns a not found status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { { email: 'new_user@example.com', encrypted_password: 'password' } }

      it 'creates a new user' do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'returns a created status' do
        post :create, params: { user: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: { email: nil } }
        }.to_not change(User, :count)
      end

      it 'returns an unprocessable entity status' do
        post :create, params: { user: { email: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
