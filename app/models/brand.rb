class Brand < ApplicationRecord
  STATUS = %w(active inactive).freeze

  has_many :products

  validates :name, presence: true
  validates :status, inclusion: { in: STATUS }
end
