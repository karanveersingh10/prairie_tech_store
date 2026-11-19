class Product < ApplicationRecord
  belongs_to :category

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]
    attachable.variant :medium, resize_to_limit: [500, 500]
    attachable.variant :large, resize_to_limit: [1000, 1000]
  end

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

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id sku name description brand current_price
      stock_quantity active category_id created_at updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category image_attachment image_blob]
  end
end