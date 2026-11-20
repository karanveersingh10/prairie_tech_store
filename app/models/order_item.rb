class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity,
            numericality: { only_integer: true, greater_than: 0 }

  validates :unit_price,
            numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    %w[id order_id product_id quantity unit_price created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[order product]
  end
end
