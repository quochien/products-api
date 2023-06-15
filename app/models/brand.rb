class Brand < ApplicationRecord
  STATUS = %w(active inactive).freeze

  validates :name, presence: true
  validates :status, inclusion: { in: STATUS }
end
