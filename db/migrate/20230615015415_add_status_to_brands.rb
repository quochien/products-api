class AddStatusToBrands < ActiveRecord::Migration[7.0]
  def change
    add_column :brands, :status, :string, default: 'active', index: true
  end
end
