class OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:index]

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    @order = Order.includes(order_items: :product).find(params[:id])
  end
end
