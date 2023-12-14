class Order < ApplicationRecord
  validates :product_name, presence: true, format: { with: /\A[a-z\-' ]+\z/i }
  validates :product_count, presence:true, numericality: { only_integer:true }
  belongs_to :customer
  validates :customer, presence:true
end
