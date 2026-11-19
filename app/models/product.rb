
class Product < ApplicationRecord
  belongs_to :category

  validates :sku, presence: true, uniqueness: true
  validates :name, presence: true
  validates :description, presence: true

  validates :current_price,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :stock_quantity,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }
end
