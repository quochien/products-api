class ProductSerializer
  include JSONAPI::Serializer

  attributes :id, :brand_id, :name, :code, :size, :color, :description, :status
end
