class BrandSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :phone, :email, :website,
    :address_line_1, :address_line_2, :address_line_3,
    :address_city, :address_state, :address_postcode,
    :address_country, :status
end
