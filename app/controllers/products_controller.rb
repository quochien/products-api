class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_brand
  before_action :find_product, only: %i(show update change_status)

  def index
    render json: ProductSerializer.new(@brand.products)
  end

  def show
    render json: ProductSerializer.new(@product)
  end

  def create
    @product = @brand.products.new(product_params)

    if @product.save
      render json: ProductSerializer.new(@product), status: :ok
    else
      render json: @product.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: ProductSerializer.new(@product), status: :ok
    else
      render json: @product.errors.messages, status: :unprocessable_entity
    end
  end

  def change_status
    if @product.update(product_status_params)
      render json: ProductSerializer.new(@product), status: :ok
    else
      render json: @product.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def find_brand
    @brand = Brand.find_by(id: params[:brand_id])
  end

  def find_product
    @product = @brand.products.find_by(id: params[:id])
  end

  def product_params
    params.require(:product)
      .permit(
        :name, :code, :size, :color,
        :description, :status
      )
  end

  def product_status_params
    params.require(:product).permit(:status)
  end
end
