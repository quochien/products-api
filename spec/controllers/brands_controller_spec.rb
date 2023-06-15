require 'rails_helper'

describe BrandsController, type: :request do
  let(:user) { create(:user) }
  let(:brand) { create(:brand, name: 'Brand 1') }
  let(:brand_params) do
    {
      name: "Brand 2",
      phone: "+1234567890",
      email: "brand2@test.com",
      website: "brand2.com",
      address_line_1: "Address line 1",
      address_line_2: "Address line 2",
      address_line_3: "Address line 3",
      address_city: "city",
      address_state: "state",
      address_postcode: "30000",
      address_country: "US"
    }
  end

  before { login_with_api(user) }

  describe 'POST #create' do
    context 'with valid prams' do
      it 'creates brand' do
        expect do
          post '/brands',
            headers: authorization_header,
            params: { brand: brand_params }
        end.to change{ Brand.count }.by(1)

        expect(response.status).to eq 200

        brand = Brand.last
        brand_params.each do |attr, value|
          expect(brand.send(attr)).to eq value
        end
        expect(brand.status).to eq 'active'
      end
    end

    context 'with invalid prams' do
      it 'fail to create brand' do
        expect do
          post '/brands',
            headers: authorization_header,
            params: {
              brand: brand_params.merge(name: '')
            }
        end.to_not change{ Brand.count }

        expect(response.status).to eq 422
      end
    end
  end

  describe 'GET #index' do
    it 'returns brands data' do
      create(:brand, name: 'Brand 1')
      create(:brand, name: 'Brand 2')

      get '/brands', headers: authorization_header

      expect(response.status).to eq 200
      expect(json['data'].size).to eq 2
    end
  end

  describe 'GET #show' do
    it 'returns brand data' do
      get "/brands/#{brand.id}", headers: authorization_header

      expect(response.status).to eq 200
      expect(json['data']['attributes']['name']).to eq 'Brand 1'
    end
  end

  describe 'PUT #update' do
    context 'with valid prams' do
      it 'updates brand' do
        put "/brands/#{brand.id}",
          headers: authorization_header,
          params: { brand: brand_params }

        expect(response.status).to eq 200

        brand.reload
        brand_params.each do |attr, value|
          expect(brand.send(attr)).to eq value
        end
      end
    end

    context 'with invalid prams' do
      it 'fail to update brand' do
        put "/brands/#{brand.id}",
          headers: authorization_header,
          params: {
            brand: brand_params.merge(name: '')
          }

        expect(response.status).to eq 422
      end
    end
  end

  describe 'POST #change_status' do
    context 'with valid prams' do
      it 'updates brand status' do
        post "/brands/#{brand.id}/change_status",
          headers: authorization_header,
          params: { brand: { status: 'inactive' } }

        expect(response.status).to eq 200

        expect(brand.reload.status).to eq 'inactive'
      end
    end

    context 'with invalid prams' do
      it 'fail to update brand status' do
        post "/brands/#{brand.id}/change_status",
          headers: authorization_header,
          params: { brand: { status: 'dummy' } }

        expect(response.status).to eq 422

        expect(brand.reload.status).to eq 'active'
      end
    end
  end
end
