class Order < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :order_items, dependent: :destroy

  validates :customer_name, :email, :address, :city,
            :province, :postal_code, presence: true
  validates :subtotal, :tax, :total,
            numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true

  before_validation :set_default_status, on: :create

  def payment_status
    "Payment pending"
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id customer_id customer_name email address city province
       postal_code subtotal tax total status created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[customer order_items]
  end

  private

  def set_default_status
    self.status ||= "pending"
  end
end
