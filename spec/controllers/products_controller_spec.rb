require 'rails_helper'

describe ProductsController, type: :request do
  let(:user) { create(:user) }
  let(:brand) { create(:brand, name: 'Brand 1') }
  let(:product) { create(:product, brand: brand, name: 'Product 1') }

  let(:product_params) do
    {
      name: "Product 2",
      code: "PROD0001",
      size: "XXL",
      color: "Blue",
      description: "First product"
    }
  end

  before { login_with_api(user) }

  describe 'POST #create' do
    context 'with valid prams' do
      it 'creates product' do
        expect do
          post "/brands/#{brand.id}/products",
            headers: authorization_header,
            params: { product: product_params }
        end.to change{ brand.products.count }.by(1)

        expect(response.status).to eq 200

        product = brand.products.last
        product_params.each do |attr, value|
          expect(product.send(attr)).to eq value
        end
        expect(product.status).to eq 'active'
      end
    end

    context 'with invalid prams' do
      it 'fail to create product' do
        expect do
          post "/brands/#{brand.id}/products",
            headers: authorization_header,
            params: { product: product_params.merge(name: '') }
        end.to_not change{ brand.products.count }

        expect(response.status).to eq 422
      end
    end
  end

  describe 'GET #index' do
    it 'returns products data' do
      create(:product, brand: brand, name: 'Product 1')
      create(:product, brand: brand, name: 'Product 2')

      get "/brands/#{brand.id}/products", headers: authorization_header

      expect(response.status).to eq 200
      expect(json['data'].size).to eq 2
    end
  end

  describe 'GET #show' do
    it 'returns product data' do
      get "/brands/#{brand.id}/products/#{product.id}", headers: authorization_header

      expect(response.status).to eq 200
      expect(json['data']['attributes']['name']).to eq 'Product 1'
    end
  end

  describe 'PUT #update' do
    context 'with valid prams' do
      it 'updates product' do
        put "/brands/#{brand.id}/products/#{product.id}",
          headers: authorization_header,
          params: { product: product_params }

        expect(response.status).to eq 200

        product.reload
        product_params.each do |attr, value|
          expect(product.send(attr)).to eq value
        end
      end
    end

    context 'with invalid prams' do
      it 'fail to update product' do
        put "/brands/#{brand.id}/products/#{product.id}",
          headers: authorization_header,
          params: { product: product_params.merge(name: '') }

        expect(response.status).to eq 422
      end
    end
  end

  describe 'POST #change_status' do
    context 'with valid prams' do
      it 'updates product status' do
        post "/brands/#{brand.id}/products/#{product.id}/change_status",
          headers: authorization_header,
          params: { product: { status: 'inactive' } }

        expect(response.status).to eq 200

        expect(product.reload.status).to eq 'inactive'
      end
    end

    context 'with invalid prams' do
      it 'fail to update product status' do
        post "/brands/#{brand.id}/products/#{product.id}/change_status",
          headers: authorization_header,
          params: { product: { status: 'dummy' } }

        expect(response.status).to eq 422

        expect(product.reload.status).to eq 'active'
      end
    end
  end
end
