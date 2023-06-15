class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.string :size
      t.string :color
      t.text :description
      t.references :brand

      t.timestamps
    end
  end
end
