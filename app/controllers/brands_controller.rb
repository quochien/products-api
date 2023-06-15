class BrandsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_brand, only: %i(show update change_status)

  def index
    render json: BrandSerializer.new(Brand.all)
  end

  def show
    render json: BrandSerializer.new(@brand)
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      render json: BrandSerializer.new(@brand), status: :ok
    else
      render json: @brand.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    if @brand.update(brand_params)
      render json: BrandSerializer.new(@brand), status: :ok
    else
      render json: @brand.errors.messages, status: :unprocessable_entity
    end
  end

  def change_status
    if @brand.update(brand_status_params)
      render json: BrandSerializer.new(@brand), status: :ok
    else
      render json: @brand.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def find_brand
    @brand = Brand.find_by(id: params[:id])
  end

  def brand_params
    params.require(:brand)
      .permit(
        :name, :phone, :email, :website,
        :address_line_1, :address_line_2, :address_line_3,
        :address_city, :address_state, :address_postcode,
        :address_country, :status
      )
  end

  def brand_status_params
    params.require(:brand).permit(:status)
  end
end
