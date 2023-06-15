require 'rails_helper'

describe Users::RegistrationsController, type: :request do
  let(:user) { build(:user) }
  let(:existing_user) { create(:user) }

  context 'When signup with new user' do
    before do
      post '/signup',
        params: {
          user: {
            email: user.email,
            password: user.password
          }
        }
    end

    it 'returns user data' do
      expect(response.status).to eq(200)
      expect(response.headers['Authorization']).to be_present
      expect(json['data']['email']).to eq(user.email)
    end
  end

  context 'when signup with existing user' do
    before do
      post '/signup',
        params: {
          user: {
            email: existing_user.email,
            password: existing_user.password
          }
        }
    end

    it 'returns error' do
      expect(response.status).to eq(422)
    end
  end
end
