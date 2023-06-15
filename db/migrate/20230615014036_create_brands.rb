class CreateBrands < ActiveRecord::Migration[7.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :website
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_line_3
      t.string :address_city
      t.string :address_state
      t.string :address_postcode
      t.string :address_country

      t.timestamps
    end
  end
end
