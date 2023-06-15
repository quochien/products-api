require 'rails_helper'

describe Users::SessionsController, type: :request do
  let(:user) { create(:user) }

  describe 'POST /login' do
    context 'with valid authentication' do
      it 'login successful' do
        login_with_api(user)

        expect(response.status).to eq(200)
        expect(response.headers['Authorization']).to be_present
      end
    end

    context 'with invalid authentication' do
      it 'login fail' do
        user.password = ''
        login_with_api(user)

        expect(response.status).to eq(401)
      end
    end
  end

  describe 'DELETE /logout' do
    it 'logout' do
      login_with_api(user)

      delete '/logout', headers: {
        'Authorization': response.headers['Authorization']
      }

      expect(response.status).to eq(200)
      expect(json['status']).to eq(200)
    end
  end
end
