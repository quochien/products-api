class Product < ApplicationRecord
  STATUS = %w(active inactive).freeze

  belongs_to :brand

  validates :name, presence: true
  validates :status, inclusion: { in: STATUS }
end
